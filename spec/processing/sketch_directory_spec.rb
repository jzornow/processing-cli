require 'processing/sketch_directory'
require 'processing/sketch'

describe Processing::SketchDirectory do
  def sketch_name_base
    "sketch_#{Time.now.strftime('%y%m%d')}"
  end

  def expect_sketch_created_with(name)
    expect(Processing::Sketch)
      .to receive(:create).with(name)
  end

  describe :create_sketch do
    context 'given a directory with no sketches from today' do
      let(:directory) do
        Processing::SketchDirectory.new double('Dir', glob: [])
      end

      context 'given a sketch name' do
        it 'creates a sketch with that name' do
          name = 'Sketch'

          expect_sketch_created_with name

          directory.create_sketch(name)
        end
      end

      context 'given no sketch name' do
        it 'creates a sketch with default name' do
          default_name = "#{sketch_name_base}a"

          expect_sketch_created_with default_name

          directory.create_sketch
        end
      end
    end

    context 'given a directory that has one previous sketch from today' do
      let(:directory) do
        dir = double(
          'Directory',
          glob: ["#{sketch_name_base}a"]
        )

        Processing::SketchDirectory.new(dir)
      end

      it 'creates a sketch with suffix of "b"' do
        expected_name = "#{sketch_name_base}b"

        expect_sketch_created_with expected_name

        directory.create_sketch
      end
    end
  end

  describe :clone_sketch do
    context 'given a sketch' do
      let(:existing_sketch_name) { "#{sketch_name_base}a" }
      let(:sketch_file_contents) { 'Some Text' }
      let(:directory) { Processing::SketchDirectory.new(Dir) }

      before(:each) do
        FileUtils.mkdir(existing_sketch_name)
        File.write(
          "#{existing_sketch_name}/#{existing_sketch_name}.pde",
          sketch_file_contents
        )
      end

      after(:each) do
        FileUtils.rm_rf existing_sketch_name
      end

      context 'given a name for the destination to clone to' do
        it 'creates a duplicate of that sketch with the name given' do
          cloned_sketch_name = 'cloned_sketch'

          directory.clone_sketch existing_sketch_name, cloned_sketch_name

          expect(Dir['*'])
            .to include(cloned_sketch_name)

          cloned_file_contents = File.read(
            "#{cloned_sketch_name}/#{cloned_sketch_name}.pde"
          )

          expect(cloned_file_contents)
            .to eq(sketch_file_contents)

          FileUtils.rm_rf cloned_sketch_name
        end
      end

      context 'given no destination name' do
        it 'creates a duplicate of that sketch with the next sequential name' do
          expected_name = "#{sketch_name_base}b"

          directory.clone_sketch existing_sketch_name, nil

          expect(Dir['*'])
            .to include(expected_name)

          cloned_file_contents = File.read(
            "#{expected_name}/#{expected_name}.pde"
          )

          expect(cloned_file_contents)
            .to eq(sketch_file_contents)

          FileUtils.rm_rf expected_name
        end
      end
    end
  end
end
