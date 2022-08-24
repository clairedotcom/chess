require_relative 'king'
require_relative 'queen'
require_relative 'bishop'
require_relative 'knight'
require_relative 'rook'
require_relative 'pawn'
require_relative 'dialogue'
require_relative 'castling'
require_relative 'utilities'

class Player
  attr_reader :id, :loser

  include Utilities
  include Dialogue
  include Castling

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

  # promotion can be any rook, bishop, queen, knight
  def promote_pawn(pawn)
    square = pawn.position
    color = pawn.color
    delete_piece(square)
    @set.pieces << select_promotion_piece.new(square, color)
  end

  def solicit_promotion_piece
    options = %w[queen rook bishop knight]
    puts 'Pawn promotion! Enter queen, rook, bishop, or knight'

    loop do
      user_input = gets.chomp

      return user_input if options.include?(user_input)

      puts 'Invalid input. Please try again.'
    end
  end

  def select_promotion_piece
    case solicit_promotion_piece
    when 'queen' then Queen
    when 'knight' then Knight
    when 'bishop' then Bishop
    when 'rook' then Rook
    end
  end
end
