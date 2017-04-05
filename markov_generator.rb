$:.unshift("./lib")

require 'datasets'

class MarkovGenerator
  attr_accessor :dictionary

  def initialize
    @dictionary = Datasets::Text.new("")
  end

  def add_data(filename)
    dictionary.merge(Datasets::File.new(filename))
  end

  def generate_sentence(current_word)
    sentence = ""
    until(current_word.chars.last.match(/[.!]/))
      current_word = next_word(current_word)
      break if current_word.nil?
      sentence += " " + current_word
    end
    sentence.lstrip
  end

  private

  def words
    dictionary.words
  end

  def next_word(current_word)
    if word_frequency = words[current_word]
      weighted_random(word_frequency)
    else
      next_word(words.keys.sample)
    end
  end

  def weighted_random(words_and_frequencies)
    words_and_frequencies.map { |word, frequency| [word] * frequency }.flatten.sample
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
