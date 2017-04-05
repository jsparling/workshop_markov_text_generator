$:.unshift("./lib")

require 'datasets'

class MarkovGenerator
  attr_accessor :dictionary


  def initialize
    @dictionary ||= {}
  end


  def add_data(filename)
    create_word_hash(word_array(filename))
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

  def create_word_hash(array_of_words)
    last_word = nil
    array_of_words.each do |word|
      if last_word
        @dictionary[last_word] ||= {}
        @dictionary[last_word][word] ||= 0
        @dictionary[last_word][word] += 1
      end
      last_word = word
    end
  end

end

mv = MarkovGenerator.new

ARGV.each do |file|
  mv.add_data(file)
end

while (print "=> "; sentence = STDIN.gets)
  sentence.strip.split(" ").each do |word|
    puts mv.generate_sentence(word)
  end
end
