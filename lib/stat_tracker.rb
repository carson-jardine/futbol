
class StatTracker
  attr_reader :game_stats,
              :league_stats,
              :season_stats

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @games = locations[:games]
    @teams = locations[:teams]
    @game_teams = locations[:game_teams]
    # require 'pry'; binding.pry
  end





  def highest_total_score
    @stat_tracker.highest_total_score
  end





















end
