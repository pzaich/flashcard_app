require 'simplecov'
require 'rspec'
SimpleCov.start
require './trainer.rb'


describe "it can load a deck and manuever through it" do
  before :each do
    File.stub!(:readlines).and_return(["term1\tdefinition1","term2\tdefinition2","term3\tdefinition3"])
    @trainer = FlashcardApp::Trainer.new('filename.txt')

  end

  it "should know its position currently in the deck" do
    @trainer.location.should eq 0
  end

  it "should move to the next card after a correct guess" do
    @trainer.guess("incorrect_term")
    @trainer.guess("term1")
    @trainer.location.should eq 1
  end

  it "should move to the next card after 3 incorrect guesses" do
    3.times {@trainer.guess("incorrect_term")}
    @trainer.location.should eq 1
  end

  it "should return a hash containing the proper response for a false answer" do
    @trainer.guess('incorrect_term').should eq ({:response => false})
  end

  it "should return a hash containing the proper response for a correct answer" do
    @trainer.guess('term1').should eq ({:response => true, :definition => "definition2"})
  end

  it "should return a hash containing the proper response for 3 incorrect guesses" do
    2.times {@trainer.guess("incorrect_term")}
    @trainer.guess('incorrect_term').should eq ({:response => false, :definition => "definition2"})
  end

  it "can return a message to the UI when the deck has run out of cards" do
    8.times {@trainer.guess("incorrect_term")}
    @trainer.guess('incoreect_term')[:out_of_cards].should eq true
  end

  it "can does not return a message to the UI when the deck has NOT run out of cards" do
    7.times {@trainer.guess("incorrect_term")}
    @trainer.guess('incoreect_term')[:out_of_cards].nil?.should be true
  end

  it "should include a way to return the first word definition directly" do
    @trainer.first_definition.should eq "definition1"
  end

  it "should return false for out_of_cards? when the deck still has cards" do
    @trainer.guess('term1')
    @trainer.out_of_cards?.should eq false
  end

  it "should return true for out_of_cards? method" do
    @trainer.guess('term1')
    @trainer.guess('term2')
    @trainer.guess('term3')
    @trainer.out_of_cards?.should eq true
  end

  it "can limit the number of cards played in a single session" do
    @trainer = FlashcardApp::Trainer.new('filename.txt', 2)
    @trainer.guess('term1')
    @trainer.guess('term2')
    @trainer.out_of_cards?.should eq true
  end
end