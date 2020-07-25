require 'CSV'
require_relative './game'
require_relative './game_stats'
require_relative './league_stats'
require_relative './game_teams'
require_relative './season_stats'
require_relative './team_stats'
require_relative './helper_methods'
require_relative './team'
require 'pry'
class StatTracker
  attr_reader :game_stats,
              :league_stats,
              :season_stats

  def self.from_csv(locations)
    StatTracker.new(locations)
  end



  def initialize(locations)
    game_path = locations[:games]
    game_teams_path = locations[:game_teams]
    team_path = locations[:teams]
    @game_stats = GameStats.new(game_path)
    @league_stats = LeagueStats.new(game_teams_path, game_path, team_path)
    @season_stats = SeasonStats.new(game_teams_path, game_path, team_path)
    @team_stats = TeamStats.new(game_teams_path, game_path, team_path)
    # @teams = locations[:teams]
    # @game_teams = locations[:game_teams]
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


#league_stats

  def best_offense
    @league_stats.best_offense
  end


#team_stats

  def team_info(id)
    @team_stats.team_info(id)
  end

#season_stats

  def worst_coach(season)
    @season_stats.worst_coach(season)
  end


end
