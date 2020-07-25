require 'CSV'
require_relative 'game'
require_relative 'game_stats'

class StatTracker
  attr_reader :game_stats,
              :league_stats,
              :season_stats

  def self.from_csv(filepath)
    StatTracker.new(filepath)
  end



  def initialize(filepath)
    @game_stats = GameStats.new(filepath)
    @team_stats = TeamStats.new(filepath)
    @league_stats = LeagueStats.new(filepath)
    @season_stats = SeasonStats.new(filepath)
  end


# game_stats

  def highest_total_score
    @game_stats.highest_total_score
  end

  def lowest_total_score
    @game_stats.lowest_total_score
  end

  def percentage_home_wins
    @game_stats.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_stats.percentage_visitor_wins
  end

  def percentage_ties
    @game_stats.percentage_ties
  end

  def count_of_games_by_season
    @game_stats.count_of_games_by_season
  end

  def average_goals_per_game
    @game_stats.average_goals_per_game
  end

  def average_goals_per_season
    @game_stats.average_goals_per_season
  end




end
