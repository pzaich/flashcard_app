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

  it "should, when requested, return the stats in compartmentalized as an array of arrays" do
    File.stub!(:readlines).and_return(["term1\tdefinition1","term2\tdefinition2","term3\tdefinition3","term4\tdefinition4","term5\tdefinition5"])
    @session = FlashcardApp::Stats.new( FlashcardApp::Deck.new("dummy_filename") )
    1.times {@session.was_guessed(FlashcardApp::Card.new("term1", "def1"))}
    2.times {@session.was_guessed(FlashcardApp::Card.new("term2", "def2"))}
    3.times {@session.was_guessed(FlashcardApp::Card.new("term3", "def3"))}
    3.times {@session.was_guessed(FlashcardApp::Card.new("term4", "def4"))}
    2.times {@session.was_guessed(FlashcardApp::Card.new("term5", "def5"))}

    @session.guessed_correct(FlashcardApp::Card.new("term1", "def1"))
    @session.guessed_correct(FlashcardApp::Card.new("term2", "def2"))
    @session.guessed_correct(FlashcardApp::Card.new("term3", "def3"))
    @session.guessed_correct(FlashcardApp::Card.new("term5", "def5"))

    @session.get.should eq [['term1'],['term2','term5'],['term3'],['term4']]

  end

end