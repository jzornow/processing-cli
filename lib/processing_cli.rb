require 'thor'

class ProcessingCLI < Thor
  desc 'create <SKETCH_NAME>', 'Creates a sketch with name SKETCH_NAME.'
  long_desc <<-LONGDESC
    Creates a sketch with name SKETCH_NAME. If no SKETCH_NAME is 
    provided, one is generated using the naming convention followed
    by Processing.app on Mac OSX:\n
      sketch_<year><month><day><sequential letter of the alphabet>\n
    sequential letter of the alphabet' is used to differentiate
    sketches produced on the same date.
  LONGDESC

  def create(sketch_name = nil)
    sketch_name ||= generate_sketch_name
    sketch_file = "#{sketch_name}/#{sketch_name}.pde"

    FileUtils.mkdir sketch_name
    FileUtils.touch sketch_file

    puts " -> Created #{sketch_name}"
  end

  private

  def generate_sketch_name
    sketch_name_base + alphabet_letter_at_index(sketches_generated_today.count)
  end

  def sketches_generated_today
    Dir.glob("#{sketch_name_base}[a-z]")
  end

  def sketch_name_base
    "sketch_#{Time.now.strftime('%y%m%d')}"
  end

  def alphabet_letter_at_index(index)
    @alphabet ||= ('a'..'z').to_a
    @alphabet[index]
  end
end

ProcessingCLI.start(ARGV)