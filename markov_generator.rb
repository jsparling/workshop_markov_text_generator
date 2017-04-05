class MarkovGenerator
  attr_accessor :dictionary

  def initialize
  end


  def add_data(filename)
    words = word_array(filename)
    create_word_hash(words)
  end

  def new_text
    dictionary
  end

  private

  def create_word_hash(array_of_words)
    return_hash = {}
    array_of_words.each do |word|
      put word
    end
  end

  def word_array(filename)
    File.open( filename ){ |f|  f.read.split }
  end

end

mv = MarkovGenerator.new

mv.add_data(ARGV.first)

# puts mv.new_text
