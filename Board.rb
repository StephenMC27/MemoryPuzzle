require_relative "Card.rb"

class Board

  attr_reader :grid #reader method for @grid instance variable

  def initialize(dimension)  #Integer === dimension and must be even
    @dimension = dimension  #length of rows/columns
    @grid = Array.new(dimension) { Array.new(dimension) }  #creates square grid with height == dimension and width == dimension
    @cards = []  #array of all cards on Board; will be passed to Board#populate
  end

  def populate
    
  end

  def create_cards
    cards = []
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



end
