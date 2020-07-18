
# require_relative './EXAMPLE_class'


class StatTracker

  def self.from_csv(filepath)
    StatTracker.new(filepath)
  end


  def initialize(filepath)
    @games = filepath[:games]
    @teams = filepath[:teams]
    @game_teams = filepath[:game_teams]

  end








end
