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
      start = solicit_start_square
      finish = solicit_finish_square

      return [start, finish] if valid_move_for_piece?(start, finish)

      puts illegal_move
    end
  end

  def solicit_start_square
    puts "Enter the location of the piece you'd like to move (e.g. a4): "

    loop do
      square = gets.chomp
      return decode_coords(square) if valid_coords?(square) && piece_at?(decode_coords(square))

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

  def valid_move_for_piece?(start, finish)
    possibilities = @current_player.get_moves_for_piece(start)
    possibilities.delete_if { |square| occupied_by_same_color?(square) }
    return true if remove_blocked_squares(possibilities, start).include?(finish)

    false
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

  def rook_bishop_move_iterator(piece)
    result = []
    lines = [piece.line1, piece.line2, piece.line3, piece.line4]

    lines.each do |line|
      line.each do |square|
        break if occupied_by_same_color?(square)

        result << square

        break if occupied_by_opposite_color?(square)
      end
    end
    result
  end

  def queen_move_iterator(piece)
    result = []
    lines = [piece.line1, piece.line2, piece.line3, piece.line4, piece.line5, piece.line6, piece.line7, piece.line8]

    lines.each do |line|
      line.each do |square|
        break if occupied_by_same_color?(square)

        result << square

        break if occupied_by_opposite_color?(square)
      end
    end
    result
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
      if !piece_at?([5, 0]) && !piece_at?([6, 0])
        [6, 0]
      end
    end

    if @curent_player == @player2
      if !piece_at?([5, 7]) && !piece_at?([6, 7])
        [6, 7]
      end
    end  
  end

  def queen_side_castle
    if @current_player == @player1
      if !piece_at?([1, 0]) && !piece_at?([2, 0]) && !piece_at?([3, 0])
        [2, 0]
      end
    end

    if @current_player == @player2
      if !piece_at?([1, 7]) && !piece_at?([2, 7]) && !piece_at?([3, 7])
        [2, 7]
      end
    end
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

  def occupied_by_opposite_color?(square)
    player = @current_player == @player1 ? @player2 : @player1

    player.set.each do |piece|
      return true if piece.position == square
    end
    false
  end

  private

  def announce_current_player
    "#{@current_player.id.capitalize}, it's your turn."
  end

  def illegal_move
    'Illegal move for that piece. Please try again.'
  end

  def invalid_input
    'Invalid input. Please enter the square number and letter (e.g. f5): '
  end

  def intro_dialogue
    puts 'Welcome to chess!'
    puts 'To save the state of your game, please enter "save" at any time.'
  end
end
