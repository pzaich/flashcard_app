require './flashcard.rb'

module FlashcardApp
  class FlashcardReader
    def initialize(filename, quiz_length = nil)
      @list = load_cards(filename)
      @location = 0
      @quiz_length = quiz_length || @list.length
    end

    def load_cards(filename)
      file = File.readlines(filename)
      @list = file.collect {|line| FlashcardApp::Flashcard.from_string(line.chomp)}
    end

    def current_flashcard
      @list[@location]
    end

    def next_flashcard
      advance!
      current_flashcard
    end

    def out_of_cards?
      @location == @quiz_length
    end


    def guess(term_guessed)
      determine_advance(current_flashcard.guess(term_guessed))
    end

    def determine_advance(guessed_right)
      if guessed_right
        advance!
        "Correct!\n" + write_next
      elsif current_flashcard.attempts == 3
        previous_term = current_flashcard.term
        advance!
        wrong + "Nevermind! Attempted 3 times. The term is #{previous_term}. Moving on...\n" + write_next
      else
        wrong
      end
    end

    def wrong
      "Wrong, Try Again.\n"
    end

    def write_next
      !out_of_cards? ? "\nWhat is this definition?\n\'#{current_flashcard.definition}\'" : "Out of cards!"
    end

    def number_correct
      @list.select { |card| card.correctly_guessed? }.length
    end

    def attempt_distribution
      distribution_array = []
      3.times do |i|
        distribution_array << @list.select {|card| card.attempts == i + 1 && card.correctly_guessed?}.map { |card| card.term }
      end
      distribution_array << @list.select {|card| card.attempts == 3 && !card.correctly_guessed?}.map { |card| card.term }
      distribution_array
    end

    private

    def advance!
      @location += 1
    end

  end
end