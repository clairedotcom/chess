# require_relative 'king'
# require_relative 'queen'
# require_relative 'bishop'
# require_relative 'knight'
# require_relative 'rook'
# require_relative 'pawn'
require_relative 'notation_translator'
require_relative 'move_validator'
require_relative 'dialogue'
require_relative 'castling'
require_relative 'set'

class Player
  attr_reader :id, :set, :loser

  include NotationTranslator
  include MoveValidator
  include Dialogue
  include Castling

  def initialize(id)
    @id = id
    @set = Set.new(id)
    @loser = false
  end

  # def generate_set
  #   case @id
  #   when :white
  #     generate_white_set
  #   when :black
  #     generate_black_set
  #   end
  # end

  # def generate_white_set
  #   set = []
  #   set << generate_white_pawns
  #   set << [Rook.new([0, 0], :white), Rook.new([7, 0], :white)]
  #   set << [Knight.new([1, 0], :white), Knight.new([6, 0], :white)]
  #   set << [Bishop.new([2, 0], :white), Bishop.new([5, 0], :white)]
  #   set << [Queen.new([3, 0], :white)]
  #   set << [King.new([4, 0], :white)]
  #   set.flatten
  # end

  # def generate_black_set
  #   set = []
  #   set << generate_black_pawns
  #   set << [Rook.new([0, 7], :black), Rook.new([7, 7], :black)]
  #   set << [Knight.new([1, 7], :black), Knight.new([6, 7], :black)]
  #   set << [Bishop.new([2, 7], :black), Bishop.new([5, 7], :black)]
  #   set << [Queen.new([3, 7], :black)]
  #   set << [King.new([4, 7], :black)]
  #   set.flatten
  # end

  # def generate_white_pawns
  #   pawns = []
  #   (0).upto(7) { |x| pawns << Pawn.new([x, 1], :white) }
  #   pawns
  # end

  # def generate_black_pawns
  #   pawns = []
  #   (0).upto(7) { |x| pawns << Pawn.new([x, 6], :black) }
  #   pawns
  # end

  def input_start_square
    loop do
      user_input = gets.chomp

      return :save if user_input == 'save'

      square = decode_coords(user_input)
      return square if valid_coords?(user_input) && same_color?(square)

      puts invalid_input_message
    end
  end

  def input_finish_square
    puts finish_square_dialogue

    loop do
      square = gets.chomp
      return decode_coords(square) if valid_coords?(square)

      puts invalid_input_message
    end
  end

  def valid_move_for_piece?(square)
    return true if @active_piece.moves.include?(square)

    false
  end

  def same_color?(square)
    return true if @set.pieces.any? { |piece| piece.position == square }

    false
  end

  def update_set(start, finish)
    get_piece_at(start).position = finish
  end

  def get_moves_for_piece(start)
    get_piece_at(start).moves
  end

  def get_piece_at(square)
    array = @set.pieces.select { |piece| piece.position == square }
    array[0]
  end

  def find_king_location
    @set.pieces.each do |piece|
      return piece.position if piece.instance_of? King
    end
  end

  def delete_piece(square)
    @set.pieces.each do |piece|
      if piece.position == square
        @set.delete(piece)
        @loser = true if piece.instance_of? King
      end
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
    when 'queen'
      Queen
    when 'knight'
      Knight
    when 'bishop'
      Bishop
    when 'rook'
      Rook
    end
  end
end
