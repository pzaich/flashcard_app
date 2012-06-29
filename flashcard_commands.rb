require './flashcard_reader.rb'

def run
  input = ""
  while input
    puts "Welcome to the flashcard app. Type q to exit, g to go. Optional: Add a number of cards to be quizzed."
    input = gets.chomp.split
    if input.first == 'q'
      return true
    elsif input.first == 'g'
      flashcard_reader = FlashcardApp::FlashcardReader.new('./flashcards.txt', (input[1].to_i unless input[1].nil?))
      puts "Your first definition:\n\'#{flashcard_reader.current_flashcard.definition}\'"
      while !flashcard_reader.out_of_cards?
        printf "\nguess your term: "
        input = gets.chomp
        puts (flashcard_reader.guess(input))
      end
      print_stats(flashcard_reader.attempt_distribution)
    else
      puts "Invalid command"
    end
  end
end

def print_stats(dist_ar)
  dist_ar.each_with_index do |term_list, index|
    unless term_list.empty?
      puts "-----------"
      index < 3 ? (puts  ("Guessed Correctly after #{index + 1 } guess(es):"))  : (puts ("You missed these questions after all 3 guesses:"))
      term_list.each {|term| puts term}
      puts "-----------"
    end
  end
end

run