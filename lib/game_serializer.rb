require 'yaml'

module GameSerializer
  def save_game
    Dir.mkdir 'game_archive' unless Dir.exist? 'game_archive'
    filename = "game_#{count_files}.yaml"
    File.open("game_archive/#{filename}", 'w') { |file| file.write(save_game_to_yaml)}
    puts game_saved_dialogue
  end

  def save_game_to_yaml
    YAML.dump(
      'player1' => @player1,
      'player2' => @player2,
      'board' => @board,
      'current_player' => @current_player
    )
  end

  def count_files
    dir = 'game_archive'
    game_count = Dir.entries(dir).count
    game_count - 1
  rescue Errno::ENOENT
    1
  end

  def load_game
    return no_saved_games_dialogue if no_saved_games?

    puts saved_game_list_dialogue
    print_existing_filenames
    load_file_contents
  end

  def load_file_contents
    filename = solicit_user_selection
    contents = YAML.load_file("game_archive/#{filename}")
    @player1 = contents['player1']
    @player2 = contents['player2']
    @board = contents['board']
    @current_player = contents['current_player']
  end

  def pull_saved_files
    files = Dir.entries('game_archive')
    files.delete_if { |name| name == '.' }
    files.delete_if { |name| name == '..' }
    files
  end

  def no_saved_games?
    return true if pull_saved_files.empty?
  end

  def print_existing_filenames
    files = pull_saved_files
    files.each do |filename|
      puts filename
    end
  end

  def solicit_user_selection
    puts load_game_dialogue

    loop do
      valid_inputs = Dir.entries('game_archive/')
      user_input = gets.chomp
      return user_input if valid_inputs.include?(user_input)

      puts 'Invalid input. Please enter a file name: '
    end
  end

  def load_game_dialogue
    'Please enter the name of the game you would like to load: '
  end

  def saved_game_list_dialogue
    'Here are the saved games to choose from: '
  end

  def game_saved_dialogue
    'Game saved'
  end

  def no_saved_games_dialogue
    puts 'There are no saved games. Start a new game: '
  end
end
