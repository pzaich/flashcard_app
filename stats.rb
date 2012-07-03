require './deck.rb'

module FlashcardApp
  class Stats

    def initialize(deck)
      @answer = {}
      @attempts = {}
      deck.size.times do |index|
        @answer[deck.return_card(index).term] = false
        @attempts[deck.return_card(index).term] = 0
      end
    end

    def attempts(card)
      @attempts[card.term]
    end

    def was_guessed(card)
      @attempts[card.term] += 1
    end

    def guessed_correct(card)
      @answer[card.term] = true
    end

    def correct?(card)
      @answer[card.term]
    end

    def get
      return_ar = [[],[],[],[]]
      @attempts.select {|key,attempt| attempt > 0}.keys.each do |key|
        if @answer[key]
          return_ar[@attempts[key] - 1] << key
        else
          return_ar[3] << key
        end
      end
      return_ar
    end
  end
end