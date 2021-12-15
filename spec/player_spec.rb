require_relative '../lib/player'

describe Player do
  subject(:test_white_player) { described_class.new(:white) }

  describe '#find_king_location' do
    context 'when a white player set is initialized' do
      it 'returns [4, 0]' do
        result = [4, 0]
        expect(test_white_player.find_king_location).to eq(result)
      end
    end
  end

  describe '#input_start_square' do
    context 'when the user inputs a2' do
      before do
        allow(test_white_player).to receive(:gets).and_return('a2')
      end

      it 'returns [0, 1]' do
        result = [0, 1]
        expect(test_white_player.input_start_square).to eq(result)
      end
    end

    context 'when the user inputs an invalid input' do
      before do
        letters = 'abcd'
        valid_input = 'e2'
        allow(test_white_player).to receive(:gets).and_return(letters, valid_input)
      end

      it 'prints an error message' do
        error_message = test_white_player.invalid_input_message
        result = [4, 1]
        expect(test_white_player).to receive(:puts).with(error_message).once
        expect(test_white_player.input_start_square).to eq(result)
      end
    end

    context 'when the users inputs "save"' do
      before do
        allow(test_white_player).to receive(:gets).and_return('save')
      end

      it 'returns :save' do
        output = :save
        expect(test_white_player.input_start_square).to eq(output)
      end
    end
  end
end
