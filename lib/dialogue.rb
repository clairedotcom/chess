module Dialogue
  def select_mode_message
    'Enter 1 for new game or 2 to load saved game: '
  end

  def invalid_mode_input_message
    'Invalid input. Please enter 1 or 2.'
  end

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

  def prompt_for_input
    puts "#{@id.capitalize}, it's your turn. Enter the location of the piece you'd like to move (e.g. a4): "
    gets.chomp
  end

  def start_square_dialogue
    "Enter the location of the piece you'd like to move (e.g. a4): "
  end

  def prompt_for_finish_square
    puts 'Which square would you like to move to? (e.g. a4): '
    gets.chomp
  end
end
