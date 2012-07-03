require './deck.rb'
require './stats.rb'


module FlashcardApp
  class Trainer

    def initialize(filename, cards_in_game = nil)
      @location = 0
      @deck = Deck.new(filename)
      @stats = Stats.new(@deck)
      @cards_in_game = cards_in_game || @deck.size
    end

    def guess(term)
      message_hash = {}
      current_card = @deck.return_card(@location)
      next_card = @deck.return_card(@location + 1) unless @location + 1 == @cards_in_game
      @stats.was_guessed(current_card)

      if current_card.guess(term)
        @location += 1
        @stats.guessed_correct(current_card)
        message_hash[:response] = true
        message_hash[:definition] = next_card.definition unless out_of_cards(message_hash)
      else
         message_hash[:response] = false
         if @stats.attempts(current_card) == 3
           @location += 1
           message_hash[:definition] = next_card.definition unless out_of_cards(message_hash)
         end
      end
      message_hash
    end

    def first_definition
      @deck.return_card(@location).definition
    end

    def out_of_cards?
      @cards_in_game == @location
    end

    private

    def out_of_cards(message_hash)
      if out_of_cards?
        message_hash[:out_of_cards] = true
      end
    end


  end
end