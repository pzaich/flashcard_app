require './card.rb'

module FlashcardApp

class Deck
  def initialize(filename)
    file_ar = File.readlines(filename)
    @contents = file_ar.collect {|line| Card.from_string(line.chomp)}
  end

  def return_card(index)
    @contents[index]
  end

  def size
    @contents.length
  end
end
end
