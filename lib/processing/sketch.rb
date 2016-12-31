module Processing
  class Sketch
    def self.create(name)
      FileUtils.mkdir name
      FileUtils.touch "#{name}/#{name}.pde"
    end
  end
end
