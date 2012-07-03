require 'simplecov'
require 'rspec'
SimpleCov.start
require './user_interface.rb'

describe 'can open and pass in a file line' do
  # before :each do
  #   run
  # end
  #


  # it "it should output the welcome message" do
  #      # STDIN.should_receive(:gets).and_return('g 4')
  #      STDOUT.should_receive(:puts).with('Your first definition')
  #      $stdin = 'g 4'
  #      input = gets.chomp
  #      if input == 'g 4'
  #             puts 'Your first definition'
  #           else
  #             puts input
  #           end
  #
  #   end
  before :each do
    File.stub!(:readlines).and_return(["term1\tdefinition1","term2\tdefinition2","term3\tdefinition3"])
    @trainer = FlashcardApp::Trainer.new('filename.txt')
  end

  it "should display the starting text when starting the flashcard trainer" do
    $stdin.stub!(:gets).and_return("hello")
    input = $stdin.gets.chomp
    puts input
    STDOUT.should_receive(:puts).with('hello')


  end

  it "should return 'Wrong, Try Again' and move on to the next card when a question is guessed 3 times" do
    # STDOUT.should_receive(:puts).with('Your first definition')
  end

  it "should return 'Wrong, Try Again' for an incorrect guess" do
  end

  it "should return 'Correct!' for a correct guess, and move onto the next card" do
  end

  it "should display 'Out of Cards!' and stop when you're out of cards" do
  end
end