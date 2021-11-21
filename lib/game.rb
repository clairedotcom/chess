require_relative '../lib/player'
require_relative '../lib/board'
require_relative '../lib/notation_translator'
require_relative '../lib/dialogue'
require_relative '../lib/game_serializer'

class Game
  include NotationTranslator
  include MoveValidator
  include Dialogue
  include GameSerializer

  def initialize
    @player1 = Player.new('white')
    @player2 = Player.new('black')
    @board = Board.new
    @current_player = @player1
  end

  def play_chess
    intro_dialogue
    turn
  end

  def turn
    @board.create_display(@player1.set, @player2.set)

    loop do
      puts announce_current_player
      move = solicit_move
      @current_player.king_side_castle if king_side_castle?(move)
      @current_player.queen_side_castle if queen_side_castle?(move)
      capture(move[1])
      update_board(move[0], move[1])
      break if game_over?

      switch_player
    end
  end

  def solicit_move
    loop do
      puts "Enter the location of the piece you'd like to move (e.g. a4): "

      start = solicit_start_square
      finish = solicit_finish_square

      return [start, finish] if valid_move_for_piece?(start, finish)

      puts illegal_move
    end
  end

  def solicit_start_square
    loop do
      square = gets.chomp
      return decode_coords(square) if valid_coords?(square) && occupied_by_same_color?(decode_coords(square))

      puts invalid_input
    end
  end

  def solicit_finish_square
    puts 'Which square would you like to move to? (e.g. a4): '

    loop do
      square = gets.chomp
      return decode_coords(square) if valid_coords?(square)

      puts invalid_input
    end
  end

  def check?
    # do any of the opposite player's possible moves contain current player's king?
  end

  def game_over?
    return true if @player1.loser == true || @player2.loser == true

    false
  end

  def capture(finish)
    @player1.delete_piece(finish) if occupied_by_opposite_color?(finish) && @current_player == @player2
    @player2.delete_piece(finish) if occupied_by_opposite_color?(finish) && @current_player == @player1
  end

  # user input error handling: is there a piece in that square?
  def occupied_by_same_color?(square)
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

  def remove_blocked_squares(possibilities, start)
    piece = @current_player.get_piece_at(start)
    piece_name = piece.class.name

    case piece_name
    when 'King'
      possibilities << king_side_castle
      possibilities << queen_side_castle
      possibilities
    when 'Knight'
      possibilities
    when 'Rook'
      rook_bishop_move_iterator(piece)
    when 'Bishop'
      rook_bishop_move_iterator(piece)
    when 'Queen'
      queen_move_iterator(piece)
    when 'Pawn'
      add_diagonal_pawn_moves(possibilities, piece)
    end
  end

  def add_diagonal_pawn_moves(possibilities, piece)
    possibilities.delete_if { |square| occupied_by_opposite_color?(square) }
    possibilities << piece.left_diagonal if occupied_by_opposite_color?(piece.left_diagonal)
    possibilities << piece.right_diagonal if occupied_by_opposite_color?(piece.right_diagonal)
    possibilities
  end

  def king_side_castle?(move)
    if @current_player == @player1 && move[1] == [6, 0]
      true
    elsif @current_player == @player2 && move[1] == [6, 7]
      true
    end
  end

  def queen_side_castle?(move)
    if @current_player == @player1 && move[1] == [2, 0]
      true
    elsif @current_player == @player2 && move[1] == [2, 7]
      true
    end
  end

  def king_side_castle
    if @current_player == @player1
      if !occupied_by_any_piece?([5, 0]) && !occupied_by_any_piece?([6, 0])
        [6, 0]
      end
    end

    if @curent_player == @player2
      if !occupied_by_any_piece?([5, 7]) && !occupied_by_any_piece?([6, 7])
        [6, 7]
      end
    end
  end

  def queen_side_castle
    if @current_player == @player1
      if !occupied_by_any_piece?([1, 0]) && !occupied_by_any_piece?([2, 0]) && !occupied_by_any_piece?([3, 0])
        [2, 0]
      end
    end

    if @current_player == @player2
      if !occupied_by_any_piece?([1, 7]) && !occupied_by_any_piece?([2, 7]) && !occupied_by_any_piece?([3, 7])
        [2, 7]
      end
    end
  end

  def occupied_by_any_piece?(square)
    return true if @player1.set.any? { |piece| piece.position == square }
    return true if @player2.set.any? { |piece| piece.position == square }

    false
  end

  def occupied_by_opposite_color?(square)
    player = @current_player == @player1 ? @player2 : @player1

    return true if player.set.any? { |piece| piece.position == square }

    false
  end
end
