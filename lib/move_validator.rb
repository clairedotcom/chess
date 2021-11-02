module MoveValidator
  def off_board?(position)
    return true if position.any? { |num| num.negative? || num > 7 }

    false
  end

  def valid_name?(input)
    pieces = %w[pawn rook knight bishop queen king castle]
    true if pieces.include?(input.downcase)
    false
  end
end
