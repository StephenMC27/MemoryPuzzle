class ComputerPlayer

  attr_accessor :known_cards, :matched_cards, :possible_positions

  def initialize(board_dimension)
    @known_cards = Hash.new { |hash, key| hash[key] = [] }
    @matched_cards = []
    @possible_positions = generate_possible_positions(board_dimension)
  end

  def first_guess
    known_cards.values do |val|
      if known_cards.values.count(val) == 2
        matching_positions = known_cards.keys.select { |key| known_cards[key] == val }
        return matching_positions[1]
      end
    end
    possible_positions.sample
  end

  def second_guess(first_guess_position)
    known_cards.each_pair do |k, v|
      if v == known_cards[first_guess_position] && k != first_guess_position
        return k
      end
    end

    loop do
      random_guess = possible_positions.sample
      return random_guess if random_guess != first_guess_position
    end
  end

  def receive_revealed_card(face_value, position)
    known_cards[position] = face_value
  end

  def receive_match(position_1, position_2)
    matched_cards << position_1
    matched_cards << position_2
    possible_positions.delete(position_1)
    possible_positions.delete(position_2)
  end

  def generate_possible_positions(dimension)
    positions = []
    (0...dimension).each do |i|
      (0...dimension).each do |j|
        positions << [i, j]
      end
    end
    positions
  end

end
