module FlashcardApp
  class Card
    attr_reader :term, :definition
    def initialize(term, definition)
      @term = term
      @definition = definition
    end

    def self.from_string(str)
      ar = str.split "\t"
      self.new(ar[0],ar[1])
    end

    def guess(term)
      term == @term
    end
  end
end