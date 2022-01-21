class Square
  def initialize(coords, value = nil)
    @coords = coords
    @color = determine_color
    @value = value
  end

  def determine_color
    (@coords[0] + @coords[1]).even? ? :black : :white
  end

  def empty?
    @value.nil?
  end
end
