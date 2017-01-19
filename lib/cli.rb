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

  desc 'clone <SOURCE_SKETCH_NAME> <DESTINATION_SKETCH_NAME>', 'Clones sketch'
  long_desc <<-LONGDESC
    Copies sketch from SORUCE_SKETCH_NAME to DESTINATION_SKETCH_NAME. If no
    DESTINATION_SKETCH_NAME is provided, the next available sketch name is
    used as a default.
  LONGDESC

  def clone(source, destination = nil)
    directory.clone_sketch source, destination
  end

  private

  def directory
    @directory ||= Processing::SketchDirectory.new
  end
end

CLI.start(ARGV)
