class MarkovGenerator
  attr_accessor :dictionary

  def initialize
  end


  def add_data(filename)
    words = word_array(filename)
  end

  def new_text
    dictionary
  end

  private

  def word_array(filename)
    File.open( filename ){ |f|  f.read.split }
  end

end

mv = MarkovGenerator.new

mv.add_data(ARGV.first)

puts mv.new_text
