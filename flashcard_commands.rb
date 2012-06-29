require './flashcard_reader.rb'



def run
  flashcard_reader = FlashcardApp::FlashcardReader.new('./flashcards.txt')
  puts "Welcome to the flashcard app. Your first definition:"
  puts "\'#{flashcard_reader.current_flashcard.definition}\'"
    while !flashcard_reader.out_of_cards?
      puts ""
      printf "guess your term: "
      input = gets.chomp
      flashcard_reader.guess input
    end
end

run