require_relative '../lib/player'
require_relative '../lib/pawn'

describe Player do
  subject(:test_white_player) { described_class.new(:white) }
  subject(:test_black_player) { described_class.new(:black) }

  describe 'generate_set' do
  end

  describe 'generate_white_set' do
    it 'creates a Rook at a1' do
      a8 = [0, 0]
      test_piece = test_white_player.generate_white_set.select { |piece| piece.position == a8 }[0]
      expect(test_piece).to be_a(Rook)
    end

    it 'creates a Rook at h1' do
      a8 = [7, 0]
      test_piece = test_white_player.generate_white_set.select { |piece| piece.position == a8 }[0]
      expect(test_piece).to be_a(Rook)
    end

    it 'creates a Knight at b1' do
      a8 = [1, 0]
      test_piece = test_white_player.generate_white_set.select { |piece| piece.position == a8 }[0]
      expect(test_piece).to be_a(Knight)
    end

    it 'creates a Knight at g1' do
      a8 = [6, 0]
      test_piece = test_white_player.generate_white_set.select { |piece| piece.position == a8 }[0]
      expect(test_piece).to be_a(Knight)
    end

    it 'creates a Bishop at c1' do
      a8 = [2, 0]
      test_piece = test_white_player.generate_white_set.select { |piece| piece.position == a8 }[0]
      expect(test_piece).to be_a(Bishop)
    end

    it 'creates a Bishop at f1' do
      a8 = [5, 0]
      test_piece = test_white_player.generate_white_set.select { |piece| piece.position == a8 }[0]
      expect(test_piece).to be_a(Bishop)
    end

    it 'creates a Queen at d1' do
      a8 = [3, 0]
      test_piece = test_white_player.generate_white_set.select { |piece| piece.position == a8 }[0]
      expect(test_piece).to be_a(Queen)
    end

    it 'creates a King at e1' do
      a8 = [4, 0]
      test_piece = test_white_player.generate_white_set.select { |piece| piece.position == a8 }[0]
      expect(test_piece).to be_a(King)
    end
  end

  describe 'generate_black_set' do
    it 'creates a Rook at a8' do
      a8 = [0, 7]
      test_piece = test_black_player.generate_black_set.select { |piece| piece.position == a8 }[0]
      expect(test_piece).to be_a(Rook)
    end

    it 'creates a Rook at h8' do
      a8 = [7, 7]
      test_piece = test_black_player.generate_black_set.select { |piece| piece.position == a8 }[0]
      expect(test_piece).to be_a(Rook)
    end

    it 'creates a Knight at b8' do
      a8 = [1, 7]
      test_piece = test_black_player.generate_black_set.select { |piece| piece.position == a8 }[0]
      expect(test_piece).to be_a(Knight)
    end

    it 'creates a Knight at g8' do
      a8 = [6, 7]
      test_piece = test_black_player.generate_black_set.select { |piece| piece.position == a8 }[0]
      expect(test_piece).to be_a(Knight)
    end

    it 'creates a Bishop at c8' do
      a8 = [2, 7]
      test_piece = test_black_player.generate_black_set.select { |piece| piece.position == a8 }[0]
      expect(test_piece).to be_a(Bishop)
    end

    it 'creates a Bishop at f8' do
      a8 = [5, 7]
      test_piece = test_black_player.generate_black_set.select { |piece| piece.position == a8 }[0]
      expect(test_piece).to be_a(Bishop)
    end

    it 'creates a Queen at d8' do
      a8 = [3, 7]
      test_piece = test_black_player.generate_black_set.select { |piece| piece.position == a8 }[0]
      expect(test_piece).to be_a(Queen)
    end

    it 'creates a King at e8' do
      a8 = [4, 7]
      test_piece = test_black_player.generate_black_set.select { |piece| piece.position == a8 }[0]
      expect(test_piece).to be_a(King)
    end
  end

  describe '#generate_black_pawns' do
    it 'generates pawn objects' do
      expect(test_black_player.generate_black_pawns.all? { |piece| piece.instance_of? Pawn }).to be true
    end

    it 'creates a pawn at [0, 6]' do
      position = [0, 6]
      expect(test_black_player.generate_black_pawns[0].position).to eq(position)
    end

    it 'creates a pawn at [1, 6]' do
      position = [1, 6]
      expect(test_black_player.generate_black_pawns[1].position).to eq(position)
    end

    it 'creates a pawn at [2, 6]' do
      position = [2, 6]
      expect(test_black_player.generate_black_pawns[2].position).to eq(position)
    end

    it 'creates a pawn at [3, 6]' do
      position = [3, 6]
      expect(test_black_player.generate_black_pawns[3].position).to eq(position)
    end

    it 'creates a pawn at [4, 6]' do
      position = [4, 6]
      expect(test_black_player.generate_black_pawns[4].position).to eq(position)
    end

    it 'creates a pawn at [5, 6]' do
      position = [5, 6]
      expect(test_black_player.generate_black_pawns[5].position).to eq(position)
    end

    it 'creates a pawn at [6, 6]' do
      position = [6, 6]
      expect(test_black_player.generate_black_pawns[6].position).to eq(position)
    end

    it 'creates a pawn at [7, 6]' do
      position = [7, 6]
      expect(test_black_player.generate_black_pawns[7].position).to eq(position)
    end
  end

  describe '#generate_white_pawns' do
    it 'generates pawn objects' do
      expect(test_white_player.generate_white_pawns.all? { |piece| piece.instance_of? Pawn }).to be true
    end

    it 'creates a pawn at [0, 1]' do
      position = [0, 1]
      expect(test_white_player.generate_white_pawns[0].position).to eq(position)
    end

    it 'creates a pawn at [1, 1]' do
      position = [1, 1]
      expect(test_white_player.generate_white_pawns[1].position).to eq(position)
    end

    it 'creates a pawn at [2, 1]' do
      position = [2, 1]
      expect(test_white_player.generate_white_pawns[2].position).to eq(position)
    end

    it 'creates a pawn at [3, 1]' do
      position = [3, 1]
      expect(test_white_player.generate_white_pawns[3].position).to eq(position)
    end

    it 'creates a pawn at [4, 1]' do
      position = [4, 1]
      expect(test_white_player.generate_white_pawns[4].position).to eq(position)
    end

    it 'creates a pawn at [5, 1]' do
      position = [5, 1]
      expect(test_white_player.generate_white_pawns[5].position).to eq(position)
    end

    it 'creates a pawn at [6, 1]' do
      position = [6, 1]
      expect(test_white_player.generate_white_pawns[6].position).to eq(position)
    end

    it 'creates a pawn at [7, 1]' do
      position = [7, 1]
      expect(test_white_player.generate_white_pawns[7].position).to eq(position)
    end
  end

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

  describe '#same_color?' do
    context 'when white pieces are at the initial position' do
      it 'returns true for square d2' do
        d2 = [3, 1]
        expect(test_white_player.same_color?(d2)).to be true
      end

      it 'returns false for square e4' do
        e4 = [4, 3]
        expect(test_white_player.same_color?(e4)).to be false
      end
    end

    context 'when black pieces are at the initial position' do
      it 'returns true for square f7' do
        f7 = [7, 6]
        expect(test_black_player.same_color?(f7)).to be true
      end

      it 'returns false for square e1' do
        e1 = [4, 0]
        expect(test_black_player.same_color?(e1)).to be false
      end
    end
  end

  describe '#update_set' do
  end

  describe '#get_moves_for_piece' do
  end

  describe '#get_piece_at' do
    context 'when the white pieces are at their initial positions' do
      it 'returns a Rook object at a1' do
        a1 = [0, 0]
        expect(test_white_player.get_piece_at(a1)).to be_a(Rook)
      end

      it 'returns nil for an empty square' do
        e5 = [4, 4]
        expect(test_white_player.get_piece_at(e5)).to be nil
      end
    end
  end

  describe '#find_king_location' do
    context 'when a white player set is initialized' do
      it 'returns [4, 0]' do
        result = [4, 0]
        expect(test_white_player.find_king_location).to eq(result)
      end
    end
  end

  describe '#delete_piece' do
    context 'when white pieces are at their initial position' do
      it 'removes the rook at a1 from the set' do
        piece = test_white_player.set[8]
        a1 = [0, 0]
        test_white_player.delete_piece(a1)
        expect(test_white_player.set).not_to include(piece)
      end
    end
  end
end
