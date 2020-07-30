require 'CSV'
require_relative 'game'

class GameStats
  attr_reader :games
  def initialize(filepath)
    @games = []
    load_games(filepath)
  end

  def load_games(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) { |data| @games << Game.new(data) }
  end

  def find_by_id(game_id)
    @games.find { |game| game.game_id == game_id }
  end

  def highest_total_score
    highest_score = @games.max_by { |game| (game.home_goals.to_i) + (game.away_goals.to_i) }
    highest_score.home_goals.to_i + highest_score.away_goals.to_i
  end

  def lowest_total_score
    lowest_score = @games.min_by { |game| (game.home_goals.to_i) + (game.away_goals.to_i) }
    lowest_score.home_goals.to_i + lowest_score.away_goals.to_i
  end

  def percentage_home_wins
    home_games = @games.group_by { |game| game.home_team_id }
    home_games_wins = home_games.map { |game_id, games| games.find_all { |game| game.home_goals > game.away_goals } }
    (home_games_wins.flatten.length / @games.count.to_f).round(2)
  end

  def percentage_visitor_wins
    away_games = @games.group_by {|game| game.away_team_id }
    away_games_wins = away_games.map { |game_id, games| games.find_all { |game| game.away_goals > game.home_goals } }
    (away_games_wins.flatten.length / @games.count.to_f).round(2)
  end

  def percentage_ties
    tied_games = @games.find_all { |game| game.home_goals == game.away_goals }
    (tied_games.count.to_f / @games.count.to_f).round(2)
  end

  def count_of_games_by_season
    games_by_season = {}
    season_by_id = games.group_by { |game| game.season }
    season_by_id.each {|season| games_by_season[season[0]] = season[1].count }
    games_by_season
  end

  def average_goals_per_game
    result = games.map { |game|  game.total_goals_for_game }
    (result.sum.to_f / result.count.to_f).round(2)
  end

  def average_goals_for_season(season_games)
    goal_totals = []
    season_games.each { |game| goal_totals << game.total_goals_for_game }
    (goal_totals.sum.to_f / goal_totals.count.to_f).round(2)
  end

  def average_goals_by_season
    avg_goals_per_season = {}
    season_by_id = games.group_by { |game| game.season }
    season_by_id.each {|season, season_games| avg_goals_per_season[season] = average_goals_for_season(season_games) }
    avg_goals_per_season
  end

end
