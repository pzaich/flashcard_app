require './flashcard.rb'

module FlashcardApp
  class FlashcardReader
    def initialize(filename)
      @list = load_cards(filename)
      @location = 0
    end

    def load_cards(filename)
      file = File.readlines(filename)
      @list = file.collect {|line| FlashcardApp::Flashcard.from_string(line.chomp)}
    end

    def current_flashcard
      @list[@location]
    end

    def out_of_cards?
      @location == @list.length
    end

    def advance!
      @location += 1
    end

    def guess(term_guessed)
      determine_advance(respond_to_guess(term_guessed))
      write_next
    end

    def respond_to_guess(term_guessed)
      guess_correct = current_flashcard.term?(term_guessed)
      guess_correct ? (puts "Correct!\n") : (puts "Wrong, Try Again.\n")
      guess_correct
    end

    def determine_advance(guessed_right)
      if guessed_right
        advance!
      elsif current_flashcard.attempts == 3
        puts "Nevermind! Attempted 3 times. The term is #{current_flashcard.term}. Moving on...\n"
        advance!
      end
    end
      # if current_flashcard.term?(term_guessed)
      #   advance!
      #   "Correct!\n" + print_card_def
      # elsif current_flashcard.attempts == 3
      #   old_term = current_flashcard.term
      #   advance!
      #   "Wrong, Try Again.\nAttempted 3 times. The term is #{old_term}\n" + print_card_def
      # else
      #   "Wrong, Try Again."
      #   end
      # end

    def write_next
      !out_of_cards? ? (puts "\nWhat is this definition?\n\'#{current_flashcard.definition}\'") : (puts "Out of cards!")
    end

  end
end