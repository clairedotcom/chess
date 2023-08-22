require_relative '../lib/rook'

describe Rook do
  subject(:test_rook) { described_class.new([0, 0], :white) }

  describe '#set_icon' do
    context 'when initialized' do
      it 'returns the correct icon string' do
        icon_string = "\e[37m\u265C \e[0m"
        expect(test_rook.icon).to eq(icon_string)
      end
    end
  end

  describe '#get_possible_moves' do
    context 'when the white rook at a1 is at its initial position' do
      it 'returns the correct array of squares' do
        rook = Rook.new([0, 0], :white)
        correct_squares = [[1, 0], [2, 0], [3, 0], [4, 0], [5,0], [6, 0], [7, 0], [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]]
        expect(rook.get_possible_moves).to match_array(correct_squares)
      end
    end
    context 'when the white rook at h1 is at its initial position' do
      it 'returns the correct array of squares' do
        rook = Rook.new([7, 0], :white)
        correct_squares = [[0, 0], [1, 0], [2, 0], [3, 0], [4, 0], [5,0], [6, 0], [7, 1], [7, 2], [7, 3], [7, 4], [7, 5], [7, 6], [7, 7]]
        expect(rook.get_possible_moves).to match_array(correct_squares)
      end
    end
    context 'when the black rook at a8 is at its initial position' do
      it 'returns the correct array of squares' do
        rook = Rook.new([0, 7], :black)
        correct_squares = [[1, 7], [2, 7], [3, 7], [4, 7], [5, 7], [6, 7], [7, 7], [0, 0], [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6]]
        expect(rook.get_possible_moves).to match_array(correct_squares)
      end
    end
    context 'when the black rook at h8 is at its initial position' do
      it 'returns the correct array of squares' do
        rook = Rook.new([7, 7], :black)
        correct_squares = [[0, 7], [1, 7], [2, 7], [3, 7], [4, 7], [5, 7], [6, 7], [7, 0], [7, 1], [7, 2], [7, 3], [7, 4], [7, 5], [7, 6]]
        expect(rook.get_possible_moves).to match_array(correct_squares)
      end
    end
    context 'when the white knigt at a1 has made a move' do
      xit 'returns the correct array of squares' do
      end
    end
  end
end
