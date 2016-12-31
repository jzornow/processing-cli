require 'thor'
require_relative './processing/sketch_directory'

class CLI < Thor
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
    directory.create_sketch sketch_name
  end

  private

  def directory
    @directory ||= Processing::SketchDirectory.new
  end
end

CLI.start(ARGV)
