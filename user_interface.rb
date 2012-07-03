require './trainer.rb'

def run
  input = ""
  while input
    puts "Welcome to the flashcard app. Type q to exit, g to go. Optional: Add a number of cards to be quizzed."
    input = gets.chomp.split
    if input.first == 'q'
      return true
    elsif input.first == 'g'
      flashcard_trainer = FlashcardApp::Trainer.new('./flashcards.txt', input[1].to_i)
      puts "Your first definition:\n\'#{flashcard_trainer.first_definition}\'"
      while !flashcard_trainer.out_of_cards?
        printf "\nguess your term: "
        input = gets.chomp
        puts print_trainer_message(flashcard_trainer.guess(input))
      end
      puts "\nOut of Cards! Your Stats for this session:"
      print_stats(flashcard_trainer.stats.get)
    else
      puts "Invalid command"
    end
  end
end

def print_stats(dist_ar)
      puts "-----------"
  dist_ar.each_with_index do |term_list, index|
    unless term_list.empty?
      index < 3 ? (puts  ("Guessed Correctly after #{index + 1 } guess(es):"))  : (puts ("You missed these questions after all 3 guesses:"))
      term_list.each {|term| puts term}
      puts "-----------"
    end
  end
end

def print_trainer_message(message_hash)
  compiled_string = ""
  if message_hash[:response]
    compiled_string = "Correct!\n"
  else
    compiled_string = "Wrong Try Again!\n"
  end

  if message_hash[:definition]
    if !message_hash[:response]
      compiled_string << "Nevermind! We need to move on...\n"
    end
    compiled_string << "Your next flashcard definition:\n#{message_hash[:definition]}\n"
  end
  compiled_string
end

run