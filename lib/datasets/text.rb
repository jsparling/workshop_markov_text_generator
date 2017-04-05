module Datasets

  class Text
    def initialize(text)
      @text = text
    end

    #{ word => { next_word => count }}
    def words
      @words ||= begin
        w = {}
        all_words = @text.split(/\s+/).map(&:downcase)
        all_words.each_with_index do |word, i|
          break if i == all_words.length
          w[word] ||= {}
          w[word][all_words[i+1]] ||= 0
          w[word][all_words[i+1]] += 1
        end
        w
      end
    end

    def merge(other)
      words
      other.words.each do |word, next_words|
        if words.has_key?(word)
          @words[word] = next_words
        else
          next_words.each do |next_word, count|
            @words[word] ||= {}
            @words[word][next_word] ||= 0
            @words[word][next_word] += count
          end
        end
      end
    end
  end
end
