require_relative 'king'
require_relative 'queen'
require_relative 'bishop'
require_relative 'knight'
require_relative 'rook'
require_relative 'pawn'
require_relative 'notation_translator'
require_relative 'move_validator'
require_relative 'dialogue'

class Player
  attr_reader :id, :set, :loser

  include NotationTranslator
  include MoveValidator
  include Dialogue

  def initialize(id)
    @id = id
    @set = generate_set
    @loser = false
  end

  def generate_set
    case @id
    when :white
      generate_white_set
    when :black
      generate_black_set
    end
  end

  def generate_white_set
    set = []
    set << generate_white_pawns
    set << [Rook.new([0, 0], :white), Rook.new([7, 0], :white)]
    set << [Knight.new([1, 0], :white), Knight.new([6, 0], :white)]
    set << [Bishop.new([2, 0], :white), Bishop.new([5, 0], :white)]
    set << [Queen.new([3, 0], :white)]
    set << [King.new([4, 0], :white)]
    set.flatten
  end

  def generate_black_set
    set = []
    set << generate_black_pawns
    set << [Rook.new([0, 7], :black), Rook.new([7, 7], :black)]
    set << [Knight.new([1, 7], :black), Knight.new([6, 7], :black)]
    set << [Bishop.new([2, 7], :black), Bishop.new([5, 7], :black)]
    set << [Queen.new([3, 7], :black)]
    set << [King.new([4, 7], :black)]
    set.flatten
  end

  def generate_white_pawns
    pawns = []
    (0).upto(7) { |x| pawns << Pawn.new([x, 1], :white) }
    pawns
  end

  def generate_black_pawns
    pawns = []
    (0).upto(7) { |x| pawns << Pawn.new([x, 6], :black) }
    pawns
  end

  def input_start_square
    loop do
      user_input = gets.chomp

      return :save if user_input == 'save'

      square = decode_coords(user_input)
      return square if valid_coords?(user_input) && same_color?(square)

      puts invalid_input_message
    end
  end

  def same_color?(square)
    return true if @set.any? { |piece| piece.position == square }

    false
  end

  def update_set(start, finish)
    @set.each do |piece|
      piece.position = finish if piece.position == start
    end
  end

  def get_moves_for_piece(start)
    get_piece_at(start).moves
  end

  def get_piece_at(square)
    @set.each do |piece|
      return piece if piece.position == square
    end
  end

  def find_king_location
    @set.each do |piece|
      return piece.position if piece.instance_of? King
    end
  end

  def delete_piece(square)
    @set.each do |piece|
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
    @set << select_promotion_piece.new(square, color)
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

  # Castling methods

  def king_side_castle_move
    case @id
    when :white
      make_white_kingside_move
    when :black
      make_black_kingside_move
    end
  end

  def queen_side_castle_move
    case @id
    when :white
      make_white_queenside_move
    when :black
      make_black_queenside_move
    end
  end

  def make_white_kingside_move
    @set.each do |piece|
      piece.position = [5, 0] if piece.position == [7, 0]
      piece.position = [6, 0] if piece.position == [4, 0]
    end
  end

  def make_white_queenside_move
    @set.each do |piece|
      piece.position = [3, 0] if piece.position == [0, 0]
      piece.position = [2, 0] if piece.position == [4, 0]
    end
  end

  def make_black_kingside_move
    @set.each do |piece|
      piece.position = [5, 7] if piece.position == [7, 7]
      piece.position = [6, 7] if piece.position == [4, 7]
    end
  end

  def make_black_queenside_move
    @set.each do |piece|
      piece.position = [3, 7] if piece.position == [0, 7]
      piece.position = [2, 7] if piece.position == [4, 7]
    end
  end
end
