class Board

  def initialize(dimension)  #Integer === dimension
    @grid = Array.new(dimension) { Array.new(dimension) }  #creates square grid with height = dimension and width = dimension
  end
end
