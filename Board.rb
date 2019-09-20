require_relative "Card.rb"
#require "byebug"
class Board

  attr_reader :cards, :dimension #reader method for @cards instance variable

  def initialize(dimension)  #Integer === dimension and must be even
    @dimension = dimension  #length of rows/columns
    @grid = Array.new(dimension) { Array.new(dimension) }  #creates square grid with height == dimension and width == dimension
    @cards = []  #array of all cards on Board
  end

  def populate
    create_cards
    place_shuffled_cards
  end

  def render
    display_column_numbers
    render_rows
  end

  def won?  #checks to see if all cards on @grid have been revealed
    cards.all? { |card| card.face_up == true }
  end

  def create_cards
    grid_area = @dimension * @dimension
    face_values = ("A".."Z").to_a.sample(grid_area / 2)   #creates array of all capital letters
    face_values.each do |face_value|
      @cards += create_card_pair(face_value)
    end
  end

  def reveal_card(position)  #takes array argument with two elements: [row, column]
    current_card = self[position]
    if current_card.face_up == false
      current_card.reveal
    end
  end

  def create_card_pair(face_value)
    card1 = Card.new(face_value)
    card2 = Card.new(face_value)
    [card1, card2]
  end

  def render_rows
    @grid.each.with_index do |row, i|
      print i  #displays row numbers of grid
      row.each do |card|
        print " "
        card.display_value
      end
      puts
    end
  end

  def display_column_numbers   #displays column numbers of grid
    print "  "
    (0...@dimension).each do |num|
      print num.to_s + " "
    end
    puts
  end

  def place_shuffled_cards  #randomly assigns cards to positions on @grid
    cards_copy = @cards.dup #duplicate array to allow values to be removed after being added to @grid while not mutating     @cards
    (0...@dimension).each do |i|
      (0...@dimension).each do |j|
        current_card = cards_copy.sample
        @grid[i][j] = current_card
        cards_copy -= [current_card]
      end
    end
  end

  def [](position)
    row, col = position
    @grid[row][col]
  end

end
