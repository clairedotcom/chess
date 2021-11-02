module MoveValidator
  def off_board?(position)
    return true if position.any? { |num| num.negative? || num > 7 }

    false
  end

  def valid_name?(input)
    pieces = %w[pawn rook knight bishop queen king castle]
    return true if pieces.include?(input.downcase)

    false
  end

  def valid_coords?(input)
    letters = %w[a b c d e f g h]
    numbers = %w[1 2 3 4 5 6 7 8]
    return true if letters.include?(input[0]) && numbers.include?(input[1])

    false
  end
end
