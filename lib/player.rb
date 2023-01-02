require_relative 'dialogue'
require_relative 'utilities'

class Player
  attr_reader :id, :loser

  include Utilities
  include Dialogue

  def initialize(id)
    @id = id
    @loser = false
  end

  def input_start_square
    loop do  
      user_input = prompt_for_input

      if user_input == 'save'
        return :save
      elsif valid_coords?(user_input)   
        return decode_coords(user_input)
      end

      puts invalid_input_message
    end
  end

  def input_finish_square
    loop do
      user_input = prompt_for_finish_square

      if user_input == 'save'
        return :save
      elsif valid_coords?(user_input)
        return decode_coords(user_input)
      end

      puts invalid_input_message
    end
  end

  private

  # Checks that user input matches the correct pattern. Move must be
  # entered as a letter a-h followed by a number 1-8
  # Input is a String
  # Returns true if input is valid
  def valid_coords?(input)
    letters = %w[a b c d e f g h]
    numbers = %w[1 2 3 4 5 6 7 8]
    return true if letters.include?(input[0]) && numbers.include?(input[1]) && input.length == 2

    false
  end

  # Converts between chess move notation (e.g. a4) to an array of
  # the corresponding board coordinates in the form [x, y]
  def decode_coords(input)
    x = 0
    letters = %w[a b c d e f g h]

    letters.each_with_index do |letter, index|
      x = index if letter == input[0]
    end

    y = input[-1].to_i - 1
    [x, y]
  end
end
