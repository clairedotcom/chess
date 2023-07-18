module Utilities
  def off_board?(position)
      return true if position.any? { |num| num.negative? || num > 7 }
  
      false
  end
  
  def color_of_piece_in_square(square)
    if occupied_by_any_piece?(square)
      piece = @game_state.select { |item| item.position == square }
      return piece[0].color
    else
      return false
    end
  end
end