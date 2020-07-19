require 'CSV'
require './lib/game'

class GameStats
  attr_reader :games
  def initialize(filepath)
    @games = []
    load_games(filepath)
  end

  def load_games(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @games << Game.new(data)
    end
  end

  def find_by_id(game_id)
    @games.find do |game|
      game.game_id == game_id
    end
  end

end
