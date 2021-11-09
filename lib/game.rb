require_relative '../lib/player'
require_relative '../lib/board'
require_relative '../lib/notation_translator'

class Game
  include NotationTranslator
  include MoveValidator

  def initialize
    @player1 = Player.new('white')
    @player2 = Player.new('black')
    @board = Board.new
    @current_player = @player1
  end

  def play_chess
    intro_dialogue
  end

  def turn
    @board.create_display(@player1.set, @player2.set)
    loop do
      move = solicit_move
      update_board(move[0], move[1])
      switch_player
    end
  end

  def solicit_move
    loop do
      start = decode_coords(solicit_start_square)
      finish = decode_coords(solicit_finish_square)

      return [start, finish] if valid_move_for_piece?(start, finish)

      puts 'Invalid move for that piece. Please try again.'
    end
  end

  def solicit_start_square
    puts "Enter the location of the piece you'd like to move (e.g. a4): "

    loop do
      square = gets.chomp
      return square if valid_coords?(square) && piece_at?(decode_coords(square))

      puts 'Invalid input. Please enter the square number and letter (e.g. f5): '
    end
  end

  def solicit_finish_square
    puts 'Which square would you like to move to? (e.g. a4): '

    loop do
      square = gets.chomp
      return square if valid_coords?(square)

      puts 'Invalid input. Please try again.'
    end
  end

  def valid_move_for_piece?(start, finish)
    possibilities = @current_player.get_moves_for_piece(start)
    possibilities.delete_if { |square| occupied_by_same_color?(square) }
    return true if remove_blocked_squares(possibilities, start, finish).include?(finish)

    false
  end

  # user input error handling: is there a piece in that square?
  def piece_at?(square)
    return true if @current_player.set.any? { |piece| piece.position == square }

    false
  end

  def update_board(start, finish)
    @current_player.update_set(start, finish)
    @board.create_display(@player1.set, @player2.set)
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def occupied_by_same_color?(square)
    @current_player.set.each do |piece|
      return true if piece.position == square
    end
    false
  end

  def remove_blocked_squares(possibilities, start, finish)
    piece = @current_player.get_piece_at(start)
    piece_name = piece.class.name

    case piece_name
    when 'King'
      possibilities
    when 'Knight'
      possibilities
    when 'Rook'
      rook_move_iterator(piece)
    when 'Bishop'
      bishop_move_iterator(possibilities, start, finish)
    when 'Queen'
      queen_move_iterator(possibilities, start, finish)
    when 'Pawn'
      possibilities.delete_if { |square| occupied_by_opposite_color?(square)}
    end
  end

  def rook_move_iterator(piece)
    result = []
    result << rook_line1_iterator(piece)
    result << rook_line2_iterator(piece)
    result << rook_line3_iterator(piece)
    result << rook_line4_iterator(piece)
    result.flatten(1)
  end

  def rook_line1_iterator(piece)
    result = []
    path = piece.line1

    path.each do |square|
      if occupied_by_any_piece?(square)
        break
      else
        result << square
      end
    end
    result
  end

  def rook_line2_iterator(piece)
    result = []
    path = piece.line2

    path.each do |square|
      if occupied_by_any_piece?(square)
        break
      else
        result << square
      end  
    end
    result
  end

  def rook_line3_iterator(piece)
    result = []
    path = piece.line3

    path.each do |square|
      if occupied_by_any_piece?(square)
        break
      else
        result << square
      end  
    end
    result
  end

  def rook_line4_iterator(piece)
    result = []
    path = piece.line4

    path.each do |square|
      if occupied_by_any_piece?(square)
        break
      else
        result << square
      end  
    end
    result
  end

  def occupied_by_any_piece?(square)
    if @player1.set.any? { |piece| piece.position == square }
      true
    elsif @player2.set.any? { |piece| piece.position == square }
      true
    else
      false
    end
  end

  def bishop_move_iterator(possible_moves, start, finish)
    # add lines to Bishop class first
  end

  def queen_move_iterator(possible_moves, start, finish)
    # combine bishop & rook iterators?
  end

  def occupied_by_opposite_color?(square)
    player = @current_player == @player1 ? @player2 : @player1

    player.set.each do |piece|
      return true if piece.position == square
    end
    false
  end

  private

  def intro_dialogue
    puts 'Welcome to chess!'
  end
end
