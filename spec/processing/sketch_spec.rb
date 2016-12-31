require 'processing/sketch'

describe Processing::Sketch do
  describe :create do
    context 'given some name' do
      it 'creates a sketch with that name' do
        name = 'some name'

        expect(FileUtils)
          .to receive(:mkdir).with(name)

        expect(FileUtils)
          .to receive(:touch).with("#{name}/#{name}.pde")

        Processing::Sketch.create(name)
      end
    end
  end
end
