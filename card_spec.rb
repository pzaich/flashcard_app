require 'simplecov'
require 'rspec'
SimpleCov.start
require './card.rb'



describe "Flashcard initialization" do
  before :each do
    @flashcard = FlashcardApp::Card.new("guess on the flashcard", "This is the definition")
    @flashcard2 = FlashcardApp::Card.new("guess on the flashcard2", "This is the definition2")
  end

  it "will create an instance of the flashcard object" do
    @flashcard.should be_an_instance_of FlashcardApp::Card
  end

  it "should have a term defined" do
    @flashcard.term.should eq("guess on the flashcard")
    @flashcard2.term.should eq("guess on the flashcard2")
  end

  it "should have a definition" do
    @flashcard.definition.should eq("This is the definition")
    @flashcard2.definition.should eq("This is the definition2")
  end

  describe 'Tab seperated initialization' do
    it 'should be able to create a flashcard from a tab separated string' do
      @flashcard = FlashcardApp::Card.from_string "class\tOpens a class definition block, which can l.guess be reopened and added to with variables and even functions."
      @flashcard2 = FlashcardApp::Card.from_string "elsif\tMuch like else, but has a higher precedence, and is usually paired with.guesss."
      @flashcard.term.should eq "class"
      @flashcard.definition.should eq "Opens a class definition block, which can l.guess be reopened and added to with variables and even functions."
      @flashcard2.term.should eq "elsif"
      @flashcard2.definition.should eq "Much like else, but has a higher precedence, and is usually paired with.guesss."
    end
  end

end

describe '#guess' do

  it "should be able to return whether the current card's term was guessed correctly" do
    @flashcard = FlashcardApp::Card.from_string "class\tOpens a class definition block, which can l.guess be reopened and added to with variables and even functions."
    @flashcard.guess("retry").should be false
    @flashcard.guess("fellow").should be false
    @flashcard.guess("hello").should be false
    @flashcard.guess("class").should be true
  end
end