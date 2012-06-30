require 'simplecov'
require 'rspec'
SimpleCov.start
require './flashcard.rb'



describe "Flashcard initialization" do
  before :each do
    @flashcard = FlashcardApp::Flashcard.new("guess on the flashcard", "This is the definition")
    @flashcard2 = FlashcardApp::Flashcard.new("guess on the flashcard2", "This is the definition2")
  end

  it "will create an instance of the flashcard object" do
    @flashcard.should be_an_instance_of FlashcardApp::Flashcard
  end

  it "should have a term defined" do
    @flashcard.term.should eq("guess on the flashcard")
    @flashcard2.term.should eq("guess on the flashcard2")
  end

  it "should have a definition" do
    @flashcard.definition.should eq("This is the definition")
    @flashcard2.definition.should eq("This is the definition2")
  end

  it "should be able to count number of times user attempts to guess it" do
    @flashcard.attempts.should eq 0
  end

  it "should have a flag for whether the.guess has been guessed correctly" do
    @flashcard.correctly_guessed?.should eq(false)
  end

  it "should equal true when it has been correctly guessed" do
    # @flashcard.correct!
    @flashcard.guess("guess on the flashcard")
    @flashcard.correctly_guessed?.should eq(true)
  end

  describe 'Tab seperated initialization' do

    it 'should be able to create a flashcard from a tab separated string' do
      @flashcard = FlashcardApp::Flashcard.from_string "class\tOpens a class definition block, which can l.guess be reopened and added to with variables and even functions."
      @flashcard2 = FlashcardApp::Flashcard.from_string "elsif\tMuch like else, but has a higher precedence, and is usually paired with.guesss."
      @flashcard.term.should eq "class"
      @flashcard.definition.should eq "Opens a class definition block, which can l.guess be reopened and added to with variables and even functions."
      @flashcard2.term.should eq "elsif"
      @flashcard2.definition.should eq "Much like else, but has a higher precedence, and is usually paired with.guesss."
    end
  end

end

describe '#guess' do

  it "should be able to guess the current card" do
    @flashcard = FlashcardApp::Flashcard.from_string "class\tOpens a class definition block, which can l.guess be reopened and added to with variables and even functions."
    @flashcard.guess("retry").should be false
    @flashcard.guess("fellow").should be false
    @flashcard.guess("hello").should be false
    @flashcard.guess("class").should be true
  end
end