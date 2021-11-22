module Dialogue
  def illegal_move_message
    'Illegal move for that piece. Please try again.'
  end

  def invalid_input_message
    'Invalid input. Please enter the square number and letter (e.g. f5): '
  end

  def intro_dialogue
    puts 'Welcome to chess!'
    puts 'To save the state of your game, please enter "save" at any time.'
  end

  def announce_current_player
    "#{@current_player.id.capitalize}, it's your turn."
  end

  def start_square_dialogue
    "Enter the location of the piece you'd like to move (e.g. a4): "
  end

  def finish_square_dialogue
    'Which square would you like to move to? (e.g. a4): '
  end
end
