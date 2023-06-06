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
end
