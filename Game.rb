require_relative "Card"
require_relative "Board"
require_relative "HumanPlayer"
require_relative "ComputerPlayer"
require "byebug"

class Game

  attr_reader :board, :player
  attr_accessor :previously_guessed_pos

  def initialize(playerClass)
    @player = playerClass.new(4)
    @board = Board.new(4)
    @previously_guessed_pos = nil
  end

  def play
    board.populate
    until board.won?
      system("clear")
      board.render
      previously_guessed_pos = player.first_guess
      formatted_previous_position = make_guess(previously_guessed_pos, player)
      sleep(2)
      system("clear")
      board.render

      currently_guessed_position = player.second_guess(formatted_previous_position)
      formatted_current_position = make_guess(currently_guessed_position, player)
      sleep(2)
      system("clear")
      board.render

      is_a_match?(formatted_previous_position, formatted_current_position)

      sleep(2)
      system("clear")
      board.render
    end
    puts "You win!"
  end

  def make_guess(pos, player)
    if player.is_a?(HumanPlayer)
      loop do
        if pos.any? { |el| el < 0 || el >= board.dimension }
          puts "That is not a valid board position!"
          sleep(1.5)
          system("clear")
          board.render
          pos = player.get_guess
        elsif board[pos].face_up
          puts "That card is already face up! Try again."
          sleep(1.5)
          system("clear")
          board.render
          pos = player.get_guess
        else
          board[pos].reveal
          return pos
        end
      end
    else
      board[pos].reveal
      player.receive_revealed_card(board[pos].face_value, pos)
      return pos
    end
  end

  def is_a_match?(previous_position, current_position)
    if board[previous_position] == board[current_position]
      player.receive_match(previous_position, current_position)
      puts "It's a match!"
    else
      puts "Not a match. Try again."
      board[previous_position].hide
      board[current_position].hide
      previously_guessed_pos = nil
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new(ComputerPlayer)
  game.play
end
