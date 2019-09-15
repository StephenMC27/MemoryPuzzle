require_relative "Card"
require_relative "Board"
require "byebug"

class Game

  attr_reader :board
  attr_accessor :previously_guessed_pos

  def initialize
    @board = Board.new(4)
    @previously_guessed_pos = nil
  end

  def play
    until board.won?
      make_guess

    end
  end

  def get_guess
    puts "Please enter the position of the card you would like to flip (e.g., '2,3')"
    guess = gets.chomp
    while !is_valid_input?(guess)
      puts
      puts "Your guess must be two integers separated by a comma. Please try again."
      guess = gets.chomp
    end
    format_guess(guess)
  end

  def is_valid_input?(guess)
    if guess.length != 3 || !guess.include?(",")
      return false
    end
    begin
      format_guess(guess)
    rescue
      false
    else
      true
    end
  end

  def format_guess(guess)
    alpha = ("a".."z").to_a + ("A".."Z").to_a
    formatted = guess.split(",")
    if formatted.any? { |el| alpha.include?(el) }
      raise InputError
    end
    formatted.map(&:to_i)
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  p game.get_guess
end
