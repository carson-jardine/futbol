require 'CSV'
require './lib/game'
require 'pry'

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

  def highest_total_score
    @games.map do |game|
      (game.home_goals) + (game.away_goals)
    end.max
  end

  def lowest_total_score
    @games.map do |game|
      (game.home_goals) + (game.away_goals)
    end.min
  end

  def percentage_home_wins(id)
    home_games = @games.find_all do |game|
      game.home_team_id == id
    end
    home_games_wins = home_games.find_all do |game|
      game.home_goals > game.away_goals
    end
    ((home_games_wins.count.to_f / home_games.count.to_f) * 100).round(2)
  end


  def percentage_away_wins(id)
    away_games = @games.find_all do |game|
      game.away_team_id == id
    end
    away_games_wins = away_games.find_all do |game|
      game.away_goals > game.home_goals
    end
    ((away_games_wins.count.to_f / away_games.count.to_f) * 100).round(2)
  end

  def percentage_ties
    tied_games = @games.find_all do |game|
      game.home_goals == game.away_goals
    end
    ((tied_games.count.to_f / @games.count.to_f) * 100).round(2)
  end



end
