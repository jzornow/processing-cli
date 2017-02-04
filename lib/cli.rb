#!/usr/bin/env ruby

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
    sketch_created = directory.create_sketch sketch_name
    puts " -> Created [#{sketch_created}]"

    open_in_editor(sketch_created)
  end

  desc 'clone <SOURCE_SKETCH_NAME> <DESTINATION_SKETCH_NAME>', 'Clones sketch'
  long_desc <<-LONGDESC
    Copies sketch from SORUCE_SKETCH_NAME to DESTINATION_SKETCH_NAME. If no
    DESTINATION_SKETCH_NAME is provided, the next available sketch name is
    used as a default.
  LONGDESC

  def clone(source, destination = nil)
    sketch_created = directory.clone_sketch source, destination
    puts " -> Cloned [#{source}] into [#{sketch_created}]"

    open_in_editor(sketch_created)
  end

  private

  def directory
    @directory ||= Processing::SketchDirectory.new
  end

  def open_in_editor(sketch_file)
    `$VISUAL #{sketch_file}`
  end
end

CLI.start(ARGV)
