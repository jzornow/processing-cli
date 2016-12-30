require 'fileutils'
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
    alphabet = ('a'..'z').to_a

    sketches_from_today = Dir.glob("#{sketch_name_base}[a-z]")

    # Print the sketches that already exist
    sketches_from_today.each { |sketch| puts " --- #{sketch}"}

    letter_suffix = alphabet[sketches_from_today.count]

    sketch_name = sketch_name_base + letter_suffix unless sketch_name
    sketch_file = "#{sketch_name}/#{sketch_name}.pde"

    FileUtils.mkdir sketch_name
    FileUtils.touch sketch_file

    puts " -*- #{sketch_name}"

    %x['/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl' #{sketch_file}]
  end

  private

  def sketch_name_base
    "sketch_#{Time.now.strftime('%y%m%d')}"
  end
end

ProcessingCLI.start(ARGV)