class HumanPlayer

  def initialize(board_dimension); end
  
  def get_guess
    puts "Please enter the position of the card you would like to flip (e.g., '2,3')"
    guess = gets.chomp
    while !is_valid_input?(guess)
      puts "Your guess must be two integers separated by a comma. Please try again."
      guess = gets.chomp
    end
    format_guess(guess)
  end

  def first_guess
    get_guess
  end

  def second_guess
    get_guess
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

  #def receive_revealed_card(face_value, position); end

  def receive_match(position_1, position_2); end

end
