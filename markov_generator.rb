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

end

mv = MarkovGenerator.new
mv.add_data

puts mv.new_text
