require_relative '../lib/pawn'

describe Pawn do
  subject(:white_pawn) { described_class.new([0, 1], :white) }
  subject(:black_pawn) { described_class.new([6, 4], :black) }

  describe '#set_icon' do
    context 'when a white pawn is initialized' do
      it 'returns the correct icon string' do
        icon_string = "\e[37m\u265F \e[0m"
        expect(white_pawn.icon).to eq(icon_string)
      end
    end

    context 'when a black pawn is initialized' do
      it 'returns the corret icon string' do
        icon_string = "\e[30m\u265F \e[0m"
        expect(black_pawn.icon).to eq(icon_string)
      end
    end
  end

  describe '#get_possible_moves' do
    context 'when the white pawn at g1 is at its initial position' do
      it 'returns the correct array of squares' do
        pawn = Pawn.new([6, 1], :white)
        correct_squares = [[5, 2],[6, 2], [6, 3], [7, 2]]
        expect(pawn.get_possible_moves).to match_array(correct_squares) 
      end
    end

    context 'when the black pawn at c7 is at its initial position' do
      it 'returns the correct array of squares' do
        pawn = Pawn.new([2, 6], :black)
        correct_squares = [[1, 5], [2, 5], [2, 4], [3, 5]]
        expect(pawn.get_possible_moves).to match_array(correct_squares)
      end
    end
  end
end
