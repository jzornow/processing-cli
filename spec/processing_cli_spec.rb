require 'processing_cli'

shared_examples 'create sketch with name' do |name_type, expected_name|
  it "creates a sketch with the #{name_type}" do
    expected_sketch_file_name = "#{expected_name}/#{expected_name}.pde"

    expect(FileUtils).to receive(:mkdir).with(expected_name)
    expect(FileUtils).to receive(:touch).with(expected_sketch_file_name)
    expect($stdout).to   receive(:puts).with include(expected_name)

    cli.create(expected_name)
  end
end

describe ProcessingCLI do
  describe :create do
    let(:cli) { ProcessingCLI.new }

    context 'given a sketch name' do
      include_examples 'create sketch with name',
                       'name given',
                       'sketch_name'
    end

    context 'given no sketch name' do
      include_examples 'create sketch with name',
                       'default name',
                       "sketch_#{Time.now.strftime('%y%m%d')}"
    end
  end
end
