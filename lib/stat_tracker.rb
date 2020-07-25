require 'CSV'
require_relative 'game'
require_relative 'game_stats'
require_relative 'league_stats'
require_relative 'game_teams'
require_relative 'season_stats'
require_relative 'team_stats'
require 'pry'
class StatTracker
  attr_reader :game_stats,
              :league_stats,
              :season_stats

  def self.from_csv(filepath)
    StatTracker.new(filepath)
  end



  def initialize(filepath)
    game_path = filepath[:game_stats]
    game_teams_path = filepath[:game_teams]
    team_path = filepath[:teams]
    @game_stats = GameStats.new(game_path)
    @league_stats = LeagueStats.new(game_teams_path, game_path, team_path)
    @season_stats = SeasonStats.new(game_teams_path, game_path, team_path)
    @team_stats = TeamStats.new(game_teams_path, game_path, team_path)
    # @teams = filepath[:teams]
    # @game_teams = filepath[:game_teams]
  end


# game_stats

  def highest_total_score
    @game_stats.highest_total_score
  end

  def lowest_total_score
    @game_stats.lowest_total_score
  end


# league_stats

  def game_teams_find_by_game_id(game_id)
    @league_stats.game_teams_find_by_game_id(game_id)
  end



#season_stats

def teams_find_by_team_id(team_id)
  @teams.find do |season_stat|
    season_stat.team_id == team_id
  end
end


end
