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


end
