require_relative './sketch'

module Processing
  class SketchDirectory
    def initialize(directory = Dir)
      @directory = directory
    end

    def create_sketch(sketch_name = nil)
      sketch_name ||= generate_sketch_name
      
      Sketch.create(sketch_name)
      puts " -> Created #{sketch_name}"
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
