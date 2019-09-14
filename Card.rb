class Card

  attr_reader :face_value

  def initialize(face_value)
    @face_value = face_value  #sets @face_value to argument (string)
    @face_up = false   #each card starts face up at beginning of game
  end

  def display_card   #only shows card's face value when @face_up == true
    if @face_up
      puts @face_value
    end
  end

  def ==(other)  #evaluates card equality based on @face_value
    self.face_value == other.face_value
  end

  def hide
    @face_up = false
  end

  def reveal
    @face_up = true
  end
end
