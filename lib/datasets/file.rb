module Datasets

  class File < Text
    def initialize(file)
      super(File.read(file))
    end
  end
end
