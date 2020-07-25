
require_relative './helper_class'


class StatTracker

  def self.from_csv(filepath)
    StatTracker.new(filepath)
  end



  def initialize(filepath)
    @game_stats  = Gamestats.new(filepath)
    @team_s

  end




end
