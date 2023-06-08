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
end
