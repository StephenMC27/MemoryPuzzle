require_relative "Card.rb"
require "byebug"
class Board

  attr_reader :cards #reader method for @cards instance variable

  def initialize(dimension)  #Integer === dimension and must be even
    @dimension = dimension  #length of rows/columns
    @grid = Array.new(dimension) { Array.new(dimension) }  #creates square grid with height == dimension and width == dimension
    @cards = []  #array of all cards on Board
  end

  def populate
    self.create_cards
    cards_copy = @cards.dup #duplicate array to allow values to be removed after being added to @grid while not mutating @cards
    (0...@dimension).each do |i|
      (0...@dimension).each do |j|
        current_card = cards_copy.sample
        @grid[i][j] = current_card
        cards_copy -= [current_card]
      end
    end
  end

  def create_cards
    grid_area = @dimension * @dimension
    face_values = ("A".."Z").to_a.sample(grid_area / 2)   #creates array of all capital letters
    face_values.each do |face_value|
      @cards += self.create_card_pair(face_value)
    end
  end

  def create_card_pair(face_value)
    card1 = Card.new(face_value)
    card2 = Card.new(face_value)
    [card1, card2]
  end

  def render
    print "  "
    (0...@dimension).each do |num|
      print num.to_s + " "   #displays column numbers of grid
    end
    puts
    @grid.each.with_index do |row, i|
      print i  #displays row numbers of grid
      row.each do |card|
        print " "
        card.display_value
      end
      puts
    end
  end

end

# board = Board.new(4)
# board.populate
# board.cards.each do |card|
#   card.reveal
# end
# board.render
