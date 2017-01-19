require 'cli'

describe CLI do
  describe :create do
    context 'given a sketch name' do
      it 'creates sketch with that name' do
        sketch_name = 'Some Sketch Name'

        expect_any_instance_of(Processing::SketchDirectory)
          .to receive(:create_sketch).with(sketch_name)

        CLI.new.create(sketch_name)
      end
    end
  end

  describe :clone do
    context 'given a sketch name' do
      it 'clones that sketch' do
        source_name = 'Bannana'
        destination_name = 'Apple'

        expect_any_instance_of(Processing::SketchDirectory)
          .to receive(:clone_sketch).with(source_name, destination_name)

        CLI.new.clone(source_name, destination_name)
      end
    end
  end
end
