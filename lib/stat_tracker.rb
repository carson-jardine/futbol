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
    # @teams = filepath[:teams]
    # @game_teams = filepath[:game_teams]
  end


# game_stats

  def highest_total_score
    @game_stats.highest_total_score
  end




end
