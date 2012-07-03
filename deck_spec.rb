require 'simplecov'
require 'rspec'
SimpleCov.start
require './deck.rb'

describe 'flashcard_deck' do
  before :each do
    #FlashcardApp::Deck.any_instance.stub(:parse_cards).and_return(cards)
    File.stub!(:readlines).and_return(["term1\tdefinition1","term2\tdefinition2","term3\tdefinition3"])
    @deck = FlashcardApp::Deck.new("dummy_filename")
  end

  it "should instantiate a new Deck object" do
    @deck.should be_an_instance_of FlashcardApp::Deck
  end

  it "should return a specified card at a given location" do
    @deck.return_card(1).term.should eq "term2"
    @deck.return_card(2).term.should eq "term3"
  end

  it "should be able to return the size of the deck" do
    @deck.size.should eq 3
  end

end
