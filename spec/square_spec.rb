require_relative '../lib/square'

describe Square do
  describe '#determine_color' do
    subject(:square_2_0) { described_class.new([2, 0]) }
    subject(:square_4_1) { described_class.new([4, 1]) }
    
    context 'when the sum of the coordinates is even' do
      it 'returns :black' do
        color = square_2_0.instance_variable_get(:@color)
        expect(color).to eq :black
      end
    end

    context 'when the sum of the coordinates is odd' do
      it 'returns :white' do
        color = square_4_1.instance_variable_get(:@color)
        expect(color).to eq :white
      end
    end
  end
end
