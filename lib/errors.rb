module Errors
  class GameModeError < StandardError
    def message
      'Input error. Please input either 1 or 2'
    end
  end
end