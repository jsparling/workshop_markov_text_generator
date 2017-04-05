module Datasets

  class Text
    def initialize(text)
      @text = text
    end

    #{ word => { next_word => count }}
    def words
      @words ||= begin
        w = {}
        all_words = @text.gsub(/[^\w\s]/, '').split(/\s+/).map(&:downcase)
        all_words.each_with_index do |word, i|
          break if i == all_words.length
          w[word] ||= {}
          w[word][all_words[i+1]] ||= 0
          w[word][all_words[i+1]] += 1
        end
        w
      end
    end
  end
end
