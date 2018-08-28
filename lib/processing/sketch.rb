module Processing
  class Sketch
    def self.create(name)
      FileUtils.mkdir name
      FileUtils.touch "#{name}/#{name}.pde"

      Sketch.new(name)
    end

    def initialize(name)
      @name = name
    end

    def open_in_editor
      `$VISUAL #{path}` if ENV['VISUAL']
    end

    def to_s
      @name
    end

    private

    def path
      "#{@name}/#{@name}.pde"
    end
  end
end
