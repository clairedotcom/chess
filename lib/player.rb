require_relative '../lib/king'
require_relative '../lib/queen'
require_relative '../lib/bishop'
require_relative '../lib/knight'
require_relative '../lib/rook'
require_relative '../lib/pawn'
require_relative '../lib/notation_translator'

class Player
  attr_reader :id, :set

  include NotationTranslator

  def initialize(id)
    @id = id
    @set = generate_set
  end

  def generate_set
    set = []

    case @id
    when 'white'
      set << generate_white_pawns
      set << [Rook.new([0, 0]), Rook.new([7, 0])]
      set << [Knight.new([1, 0]), Knight.new([6, 0])]
      set << [Bishop.new([2, 0]), Bishop.new([5, 0])]
      set << [Queen.new([3, 0])]
      set << [King.new([4, 0])]
    when 'black'
      set << generate_black_pawns
      set << [Rook.new([0, 7]), Rook.new([7, 7])]
      set << [Knight.new([1, 7]), Knight.new([6, 7])]
      set << [Bishop.new([2, 7]), Bishop.new([5, 7])]
      set << [Queen.new([3, 7])]
      set << [King.new([4, 7])]
    end
    set.flatten
  end

  def generate_white_pawns
    pawns = []
    (0).upto(7) { |x| pawns << Pawn.new([x, 1], 'white') }
    pawns
  end

  def generate_black_pawns
    pawns = []
    (0).upto(7) { |x| pawns << Pawn.new([x, 6], 'black') }
    pawns
  end

  def update_set(piece, move)
    @set.each do |p|
      if p.instance_of?(piece) && p.moves.include?(move)
        p.position = move
      end
    end
  end

  def get_piece_location(piece, move)
    @set.each do |p|
      if p.instance_of?(piece) && p.moves.include?(move)
        return p.position
      end
    end
  end

  def move_possible?(piece, move)
    @set.each do |p|
      if p.instance_of?(piece) && p.moves.include?(move)
        return true
      end
    end
    false
  end
end
