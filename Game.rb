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
    board.populate
    until board.won?
      system("clear")
      board.render

      previously_guessed_pos = get_guess
      previous_card = make_guess(previously_guessed_pos)
      system("clear")
      board.render

      currently_guessed_position = get_guess
      current_card = make_guess(currently_guessed_position)
      system("clear")
      board.render

      is_a_match?(previous_card, current_card)

      sleep(2)
      system("clear")
      board.render
    end
    puts "You win!"
  end

  def get_guess
    puts "Please enter the position of the card you would like to flip (e.g., '2,3')"
    guess = gets.chomp
    while !is_valid_input?(guess)
      puts "Your guess must be two integers separated by a comma. Please try again."
      guess = gets.chomp
    end
    format_guess(guess)
  end

  def make_guess(pos)
    loop do
      if board[pos].face_up
        puts "That card is already face up! Try again."
        sleep(1.5)
        system("clear")
        board.render
        pos = get_guess
      else
        board[pos].reveal
        return board[pos]
      end
    end
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

  def is_a_match?(previous_card, current_card)
    if previous_card == current_card
      puts "It's a match!"
    else
      puts "Not a match. Try again."
      previous_card.hide
      current_card.hide
      previously_guessed_pos = nil
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
  game.play
end
