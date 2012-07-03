require 'simplecov'
require 'rspec'
SimpleCov.start
require './stats.rb'

describe "statistics for the answers given to a deck of flash cards" do
  before :each do
    File.stub!(:readlines).and_return(["term1\tdefinition1","term2\tdefinition2","term3\tdefinition3"])
    @session = FlashcardApp::Stats.new( FlashcardApp::Deck.new("dummy_filename") )
    @card = FlashcardApp::Card.new("term1", "definition1")
  end

  it "should return the number of attempts for a card" do
    @session.attempts(@card).should eq 0
  end

  it "should return whether a card correctly guessed" do
    @session.guessed_correct(@card)
    @session.correct?(@card).should eq true
  end

  it "should return false until a card is guessed correctly" do
     @session.correct?(@card).should eq false
  end

  it "should return the number of attempts for a card wrongly guessed" do
    2.times {@session.was_guessed(@card)}
    @session.attempts(@card).should eq 2
  end

end