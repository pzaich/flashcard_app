require 'simplecov'
require 'rspec'
SimpleCov.start
require './flashcard_reader.rb'

describe 'flash_card_reader methods' do
  before :each do
    @flashcard_reader = FlashcardApp::FlashcardReader.new("./flashcards.txt")
  end

  describe "flashcard trainer methods"
    it "should move to the next card if the answer is correct" do
      @flashcard_reader.guess("alias")
      @flashcard_reader.guess("and").should eq "Correct!\n\nWhat is this definition?\n'Designates code that must be run unconditionally at the beginning of the program before any other.'"
    end

    it "should reveal the current term and move on after 3 incorrect guesses" do
      @flashcard_reader.guess("and")
      @flashcard_reader.guess("class")
      @flashcard_reader.guess("bubbleyum")
      @flashcard_reader.guess("and").should eq "Correct!\n\nWhat is this definition?\n'Designates code that must be run unconditionally at the beginning of the program before any other.'"
    end

    it "should not show a next definition prompt if it is out of cards" do
      37.times {@flashcard_reader.next_flashcard}
      @flashcard_reader.guess("yield").should eq "Correct!\nOut of cards!"
    end

    it "should check to see if it is out of cards" do
      @flashcard_deck.out_of_cards?.should be false
      38.times   {@flashcard_reader.next_flashcard}
      @flashcard_deck.out_of_cards?.should be true
    end

    it "should say wrong answer when the answer is incorrect" do
      @flashcard_reader.guess("and").should eq "Wrong, Try Again.\n"
    end
  end
end

describe "flash card trainer new instance defaults" do
  before :each do
    @flashcard_reader = FlashcardApp::FlashcardTrainer.new('./flashcards.txt', 12)
    12.times {@flashcard_reader.next_flashcard}
  end

  it "should be out of cards" do
    @flashcard_reader.out_of_cards?.should be true
  end
end




describe "return accurate specs after flashcards are complete" do
  before :each do
    @flashcard_reader = FlashcardApp::FlashcardReader.new('./flashcards.txt', 10)
    @flashcard_reader.guess("alias")
    @flashcard_reader.guess("and")
    @flashcard_reader.guess("and")
    @flashcard_reader.guess("BEGIN")
    @flashcard_reader.guess("and")
    @flashcard_reader.guess("and")
    @flashcard_reader.guess("begin")
    18.times {@flashcard_reader.guess("a"*5)}
  end

  it "should give us the number of correct answers" do
    @flashcard_reader.number_correct.should eq(4)
  end

  it "should give us the an array of attempts" do
    @flashcard_reader.attempt_distribution[0].should eq ['alias','and']
    @flashcard_reader.attempt_distribution[1].should eq ['BEGIN']
    @flashcard_reader.attempt_distribution[2].should eq ['begin']
    @flashcard_reader.attempt_distribution[3][0].should eq 'break'
    @flashcard_reader.attempt_distribution[3][-1].should eq 'do'
  end

end