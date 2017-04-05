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

  def generate_sentence(current_word)
    sentence = ""
    until(current_word.chars.last.match(/[.!]/))
      current_word = next_word(current_word)
      sentence += " " + current_word
    end
    sentence.lstrip
  end

  private
  
  def next_word(current_word)
    if word_frequency = @dictionary[current_word]
      weighted_random(word_frequency)
    else
      next_word(@dictionary.keys.sample)
    end
  end

  def weighted_random(words_and_frequencies)
    words_and_frequencies.map { |word, frequency| [word] * frequency }.flatten.sample
  end

  private

  def word_array(filename)
    File.open( filename ){ |f|  f.read.split }
  end
end

mv = MarkovGenerator.new

mv.add_data(ARGV.first)

while (print "=> "; sentence = STDIN.gets)
  sentence.strip.split(" ").each do |word|
    puts mv.generate_sentence(word)
  end
end
