require 'simplecov'
require 'rspec'
SimpleCov.start
require './flashcard_reader.rb'

describe 'flash_card_reader methods' do
  before :each do
    @flashcard_reader = FlashcardApp::FlashcardReader.new("./flashcards.txt")
  end

  it "should instantiate a flash_card_reader" do
    @flashcard_reader.should be_an_instance_of FlashcardApp::FlashcardReader
  end

  it "should load the file in order and return the current slide" do
    @flashcard_reader.current_flashcard.term.should eq "alias"
    @flashcard_reader.current_flashcard.definition.should eq "To create a second name for the variable or method."
  end

  it "should be able to advance the card" do
    @flashcard_reader.advance!
    @flashcard_reader.current_flashcard.term.should eq "and"
    @flashcard_reader.current_flashcard.definition.should eq "A command that appends two or more objects together."
  end

  it "should guess the current definition" do
    @flashcard_reader.guess("and").should eq "Wrong, Try Again."
    @flashcard_reader.guess("class").should eq "Wrong, Try Again."
    @flashcard_reader.guess("alias").should eq "Correct!\n\nWhat is this definition?\n'A command that appends two or more objects together.'"
    @flashcard_reader.guess("and").should eq "Correct!\n\nWhat is this definition?\n'Designates code that must be run unconditionally at the beginning of the program before any other.'"
  end

  it "should guess the current definition and move on after 3 guesses" do
    @flashcard_reader.guess("and").should eq "Wrong, Try Again."
    @flashcard_reader.guess("class").should eq "Wrong, Try Again."
    @flashcard_reader.guess("bubbleyum").should eq "Wrong, Try Again.\nAttempted 3 times. The term is alias\n\nWhat is this definition?\n'A command that appends two or more objects together.'"
    @flashcard_reader.guess("and").should eq "Correct!\n\nWhat is this definition?\n'Designates code that must be run unconditionally at the beginning of the program before any other.'"
  end

  it "should not show a next definition prompt if it is out of cards" do
    37.times {@flashcard_reader.advance!}
    @flashcard_reader.guess("yield").should eq "Correct!\nOut of cards!"
  end

  it "should check to see if it is out of cards" do
    @flashcard_reader.out_of_cards?.should be false
    38.times   {@flashcard_reader.advance!}
    @flashcard_reader.out_of_cards?.should be true
  end

end