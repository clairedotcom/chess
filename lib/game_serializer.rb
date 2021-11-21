require 'yaml'

module GameSerializer
  def save_game
    Dir.mkdir 'game_archive' unless Dir.exist? 'game_archive'
    #name files game_1, game_2, etc
  end

  def save_game_to_yaml

  end  
end
