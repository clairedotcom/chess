module NotationTranslator
  def decode_coords(input)
    x = 0
    letters = %w[a b c d e f g h]

    letters.each_with_index do |letter, index|
      x = index if letter == input[0]
    end

    y = input[-1].to_i - 1
    [x, y]
  end

  def name_to_class(input)
    {
      'pawn' => Pawn,
      'rook' => Rook,
      'knight' => Knight,
      'bishop' => Bishop,
      'queen' => Queen,
      'king' => King
    }[input]
  end
end
