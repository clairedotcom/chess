require_relative '../lib/player'
require_relative '../lib/pawn'

describe Player do
  subject(:test_white_player) { described_class.new(:white) }
  subject(:test_black_player) { described_class.new(:black) }

  describe '#input_start_square' do
    context 'when the user inputs a2' do
      before do
        allow(test_white_player).to receive(:gets).and_return('a2')
        allow($stdout).to receive(:puts)
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
        prompt_message = "White, it's your turn. Enter the location of the piece you'd like to move (e.g. a4): "
        expect($stdout).to receive(:puts).with(prompt_message).twice
        expect($stdout).to receive(:puts).with(error_message).once
        test_white_player.input_start_square
      end
    end

    context 'when the user inputs "save"' do
      before do
        allow(test_white_player).to receive(:gets).and_return('save')
        allow($stdout).to receive(:puts)
      end

      it 'returns :save' do
        output = :save
        expect(test_white_player.input_start_square).to eq(output)
      end
    end
  end

  describe '#input_finish_square' do
    context 'when the user inputs e6' do
      before do
        allow(test_white_player).to receive(:gets).and_return('e6')
        allow($stdout).to receive(:puts)
      end

      it 'returns [4, 5]' do
        expect(test_white_player.input_finish_square).to eq([4, 5])
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
        prompt_message = 'Which square would you like to move to? (e.g. a4): '
        expect($stdout).to receive(:puts).with(error_message).once
        expect($stdout).to receive(:puts).with(prompt_message).twice
        test_white_player.input_finish_square
      end
    end
  end
end
