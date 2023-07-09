require_relative '../lib/move_referee.rb'
require_relative '../lib/board.rb'
require_relative '../lib/game.rb'
require_relative '../lib/move.rb'

describe MoveReferee do
  describe 'check_rook' do
    context 'when a rook is moved illegally from h1 to h3' do
    #move is illegal because there's a pwan in h2
      it 'move.valid remains false' do
        board = Board.new
        game = Game.new
        game_state = Game.new.format_board_state
        piece = board.get_square(7, 0)
        whiterookmove = Move.new([7,0], [7,2])
        referee = MoveReferee.new(game_state, piece, whiterookmove)
        referee.move_valid
        expect(whiterookmove.valid).to eq false
      end
    end

    context 'when a rook is moved illegally from h1 to f3' do
      #move is illegal because rook does not move diagonally
        it 'move.valid remains false' do
          board = Board.new
          game = Game.new
          game_state = Game.new.format_board_state
          piece = board.get_square(7, 0)
          whiterookmove = Move.new([7,0], [5,2])
          referee = MoveReferee.new(game_state, piece, whiterookmove)
          referee.move_valid
          expect(whiterookmove.valid).to eq false
        end
      end

    context 'when a rook is moved legally from h1 to h3' do
      it 'move.valid is set from false to true' do
        board = Board.new
        board.update_board([7, 1], [7, 3])
        board.get_square(7, 3).position = [7, 3]
        game_state = board.state.flatten.delete_if { |element| element.nil? }
        piece = board.get_square(7, 0)
        whiterookmove = Move.new([7, 0], [7, 2])
        referee = MoveReferee.new(game_state, piece, whiterookmove)
        referee.move_valid
        expect(whiterookmove.valid).to eq true
      end
    end
  end
end