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

  def expect_successful_creation_message(name)
    expect($stdout)
      .to receive(:puts).with(" -> Created #{name}")
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
          expect_successful_creation_message name

          directory.create_sketch(name)
        end
      end

      context 'given no sketch name' do
        it 'creates a sketch with default name' do
          default_name = "#{sketch_name_base}a"

          expect_sketch_created_with default_name
          expect_successful_creation_message default_name

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
        expect_successful_creation_message expected_name

        directory.create_sketch
      end
    end
  end

  describe :clone_sketch do
    context 'given a sketch' do
      let(:existing_sketch_name) { "#{sketch_name_base}a" }
      let(:cloned_sketch_name) { "#{sketch_name_base}b" }
      let(:sketch_file_contents) { 'Some Text' }
      let(:directory) { Processing::SketchDirectory.new(Dir) }

      before(:each) do
        directory = Processing::SketchDirectory.new(Dir)

        FileUtils.mkdir(existing_sketch_name)
        FileUtils.touch("#{existing_sketch_name}/#{existing_sketch_name}.pde")
      end

      after(:each) do
        FileUtils.rm_rf [existing_sketch_name, cloned_sketch_name]
      end

      it 'creates a duplicate of that sketch with the next sequential name' do
        successful_clone_message = " -> Cloned #{existing_sketch_name} into " \
                                   "#{cloned_sketch_name}"
        expect($stdout)
          .to receive(:puts).with(successful_clone_message)

        directory.clone_sketch existing_sketch_name

        expect(Dir['*'])
          .to include(cloned_sketch_name)
      end
    end
  end
end