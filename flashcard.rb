module FlashcardApp
  class Flashcard
    attr_reader :term, :definition, :attempts
    def initialize(term, definition)
      @term = term
      @definition = definition
      @attempts = 0
    end

    def self.from_string(str)
      ar = str.split "\t"
      self.new(ar[0],ar[1])
    end

    def increment!
      @attempts += 1
    end

    def term?(term_guess)
      increment!
      term_guess == @term
    end
  end
end