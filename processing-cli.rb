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
    now = Time.now

    sketch_name_base = 'sketch_' +
                       (now.year - 2000).to_s.ljust(2,'0') +
                       now.mon.to_s.ljust(2, '0') +
                       now.mday.to_s.ljust(2, '0')

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
end

ProcessingCLI.start(ARGV)