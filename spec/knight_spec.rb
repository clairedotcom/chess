require_relative '../lib/knight'

describe Knight do
  subject(:white_knight) { described_class.new([1, 0], :white) }
  subject(:black_knight) { described_class.new([6, 7], :black) }

  describe '#set_icon' do
    context 'when a white knight initialized' do
      it 'returns the correct icon string' do
        expected_icon = "\e[37m\u265E \e[0m"
        expect(white_knight.icon).to eq(expected_icon)
      end
    end

    context 'when a black knight initialized' do
      it 'returns the correct icon string' do
        expected_icon = "\e[30m\u265E \e[0m"
        expect(black_knight.icon).to eq(expected_icon)
      end
    end
  end

  describe '#get_possible_moves' do
    context 'when the white knight at g1 is at its initial position' do
      it 'returns an array with the correct squares' do
        knight = Knight.new([6, 0], :white)
        correct_squares = [[7, 2], [5, 2], [4, 1]]
        expect(knight.possible_moves).to match_array(correct_squares)
      end
    end

    context 'when the white knight at b1 is at its initial position' do
      it 'returns an array with the correct squares' do
        knight = Knight.new([1, 0], :white)
        correct_squares = [[0, 2], [2, 2], [3, 1]]
        expect(knight.possible_moves).to match_array(correct_squares)
      end
    end

    context 'when the black knight at b8 is at its initial position' do
      it 'returns an array with the correct squares' do
        knight = Knight.new([1, 7], :black)
        correct_squares = [[0, 5], [2, 5], [3, 6]]
        expect(knight.possible_moves).to match_array(correct_squares)
      end
    end

    context 'when the black knight at g8 is at its initial position' do
      it 'returns an array with the correct squares' do
        knight = Knight.new([6, 7], :black)
        correct_squares = [[7, 5], [5, 5], [4, 6]]
        expect(knight.possible_moves).to match_array(correct_squares)
      end
    end
  end
end
