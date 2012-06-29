require 'simplecov'
require 'rspec'
SimpleCov.start
require './flashcard.rb'



describe "create a flashcard object" do
  before :each do
  @flashcard = FlashcardApp::Flashcard.new("Term on the flashcard", "This is the definition")
  @flashcard2 = FlashcardApp::Flashcard.new("Term on the flashcard2", "This is the definition2")
  end

  it "will create an instance of the flashcard object" do
    @flashcard.should be_an_instance_of FlashcardApp::Flashcard
  end

  it "should have a term defined" do
    @flashcard.should respond_to :term
    @flashcard.term.should eq("Term on the flashcard")
    @flashcard2.term.should eq("Term on the flashcard2")
  end

  it "should have a definition" do
    @flashcard.should respond_to :definition
    @flashcard.definition.should eq("This is the definition")
    @flashcard2.definition.should eq("This is the definition2")
  end

  it "should be able to count its attempts" do
    @flashcard.should respond_to :attempts
    @flashcard.attempts.should eq 0
    @flashcard.attempts.should be_an_instance_of Fixnum
  end

  it "should increment its attempts counter" do
    @flashcard.increment!
    @flashcard.attempts.should eq 1
  end

  it "should have a flag for whether the term has been guessed correctly the first time" do
    @flashcard.correctly_guessed?.should eq(false)
  end

  it "should equal true when it has been correctly guessed" do
    @flashcard.correct!
    @flashcard.correctly_guessed?.should eq(true)
  end

end

describe 'create a flashcard from a tab separated string' do
  before :each do
    @flashcard = FlashcardApp::Flashcard.from_string "class\tOpens a class definition block, which can later be reopened and added to with variables and even functions."
  end

  it 'is able to create a flashcard from a tab separated string' do
    @flashcard.term.should eq "class"
    @flashcard.definition.should eq "Opens a class definition block, which can later be reopened and added to with variables and even functions."

    @flashcard2 = FlashcardApp::Flashcard.from_string "elsif\tMuch like else, but has a higher precedence, and is usually paired with terms."
    @flashcard2.term.should eq "elsif"
    @flashcard2.definition.should eq "Much like else, but has a higher precedence, and is usually paired with terms."
  end

  it "should be able to guess the current card" do
    @flashcard.term?("retry").should be false
    @flashcard.term?("fellow").should be false
    @flashcard.term?("hello").should be false
    @flashcard.term?("class").should be true
  end
end