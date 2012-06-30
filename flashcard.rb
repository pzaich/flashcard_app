module FlashcardApp
  class Flashcard
    attr_reader :term, :definition, :attempts
    def initialize(term, definition)
      @term = term
      @definition = definition
      @attempts = 0
      @guessed = false
    end

    def self.from_string(str)
      ar = str.split "\t"
      self.new(ar[0],ar[1])
    end

    def guess(term_guess)
      @attempts +=1
      if term_guess == @term
        @guessed = true
        true
      else
        false
      end
    end

    def correctly_guessed?
      @guessed
    end



  end
end