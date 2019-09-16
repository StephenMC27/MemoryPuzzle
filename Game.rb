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
      while board[previously_guessed_pos].face_up
        puts "That card is already face up! Try again."
        sleep(1.5)
        system("clear")
        board.render
        previously_guessed_pos = get_guess
      end
      previous_card = board[previously_guessed_pos]
      previous_card.reveal
      system("clear")
      board.render
      currently_guessed_position = get_guess
      while board[currently_guessed_position].face_up
        puts "That card is already face up! Try again."
        sleep(1.5)
        system("clear")
        board.render
        currently_guessed_position = get_guess
      end
      current_card = board[currently_guessed_position]
      current_card.reveal
      system("clear")
      board.render
      if board[previously_guessed_pos] == board[currently_guessed_position]
        puts "It's a match!"
      else
        puts "Not a match. Try again."
        previous_card.hide
        current_card.hide
        previously_guessed_pos = nil
      end
      sleep(2)
    end
    puts "You win!"
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
  game.play
end
