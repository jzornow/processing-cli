require 'cli'

describe CLI do
  describe :create do
    context 'given a sketch name' do
      it 'creates sketch with that name' do
        sketch_name = 'Some Sketch Name'
        cli = CLI.new

        expect_any_instance_of(Processing::SketchDirectory)
          .to receive(:create_sketch)
                .with(sketch_name)
                .and_return(sketch_name)

          expect($stdout)
            .to receive(:puts).with(" -> Created [#{sketch_name}]")

          expect(cli)
            .to receive(:open_in_editor).with(sketch_name)

        cli.create(sketch_name)
      end
    end
  end

  describe :clone do
    context 'given a sketch name' do
      it 'clones that sketch' do
        source_name = 'Bannana'
        destination_name = 'Apple'
        cli = CLI.new

        expect_any_instance_of(Processing::SketchDirectory)
          .to receive(:clone_sketch)
          .with(source_name, destination_name)
          .and_return(destination_name)

        expect($stdout)
          .to receive(:puts).with " -> Cloned [#{source_name}] into " \
                                   "[#{destination_name}]"

        expect(cli)
          .to receive(:open_in_editor).with(destination_name)

        cli.clone(source_name, destination_name)
      end
    end
  end
end
