require 'CSV'
require_relative 'game'
require_relative 'game_stats'
require_relative 'league_stats'
require_relative 'game_teams'
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
    binding.pry
    # @teams = filepath[:teams]
    # @game_teams = filepath[:game_teams]
  end


# game_stats

  def highest_total_score
    @game_stats.highest_total_score
  end

  def game_teams_find_by_game_id(game_id)
    @game_teams.find do |season_stat|
      season_stat.game_id == game_id
    end
  end



end
