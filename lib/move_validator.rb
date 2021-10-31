module MoveValidator
  def off_board?(position)
    return true if position.any? {|num| num < 0 || num > 7}

    false
  end
end
