require_relative './king'
require_relative './queen'
require_relative './bishop'
require_relative './knight'
require_relative './rook'
require_relative './pawn'
require_relative './notation_translator'

class Player
  attr_reader :id, :set, :loser

  include NotationTranslator

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
    set << [Rook.new([0, 0]), Rook.new([7, 0])]
    set << [Knight.new([1, 0]), Knight.new([6, 0])]
    set << [Bishop.new([2, 0]), Bishop.new([5, 0])]
    set << [Queen.new([3, 0])]
    set << [King.new([4, 0])]
    set.flatten
  end

  def generate_black_set
    set = []
    set << generate_black_pawns
    set << [Rook.new([0, 7]), Rook.new([7, 7])]
    set << [Knight.new([1, 7]), Knight.new([6, 7])]
    set << [Bishop.new([2, 7]), Bishop.new([5, 7])]
    set << [Queen.new([3, 7])]
    set << [King.new([4, 7])]
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
