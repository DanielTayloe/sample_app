class Wordness
  attr_accessor :word

  def initialize(attributes = {})
    @word = attributes[:word]
  end
  
  def shuffler
	p @word.split('').to_a.shuffle.join
  end
end

