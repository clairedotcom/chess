module MoveValidator
  def off_board?(position)
    return true if position.any? { |num| num.negative? || num > 7 }

    false
  end

  def valid_coords?(input)
    letters = %w[a b c d e f g h]
    numbers = %w[1 2 3 4 5 6 7 8]
    return true if letters.include?(input[0]) && numbers.include?(input[1]) && input.length == 2

    false
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
        break if piece.color == color_of_piece_in_square(square)

        result << square

        break if occupied_by_opposite_color?(square)
      end
    end
    result
  end
end

def color_of_piece_in_square(square)
  if occupied_by_any_piece?(square)
    piece = @game_state.select { |item| item.position == square }
    piece[0].color
  end
end
