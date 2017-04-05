class MarkovGenerator
  attr_accessor :dictionary

  def initialize

  end

  def add_data()
    @dictionary = [["name", 12], ["blah", 3]]
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
    puts sentence.lstrip
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
end

mv = MarkovGenerator.new
mv.add_data

puts mv.new_text
