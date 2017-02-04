require_relative './sketch'

module Processing
  class SketchDirectory
    def initialize(directory = Dir)
      @directory = directory
    end

    def create_sketch(sketch_name = nil)
      sketch_name ||= generate_sketch_name

      Sketch.create(sketch_name)
    end

    def clone_sketch(source, destination)
      destination ||= generate_sketch_name
      FileUtils.cp_r(source, destination)

      Dir["#{destination}/#{source}*"].each do |file|
        FileUtils.mv(file, "#{destination}/#{destination}.pde")
      end

      Sketch.new(destination)
    end

    private

    def generate_sketch_name
      [
        sketch_name_base,
        alphabet_letter_at_index(sketches_generated_today.count)
      ].join
    end

    def sketches_generated_today
      @directory.glob("#{sketch_name_base}[a-z]")
    end

    def sketch_name_base
      "sketch_#{Time.now.strftime('%y%m%d')}"
    end

    def alphabet_letter_at_index(index)
      @alphabet ||= ('a'..'z').to_a
      @alphabet[index]
    end
  end
end
