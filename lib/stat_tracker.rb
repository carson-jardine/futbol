<<<<<<< HEAD
require_relative './helper_class'
=======

# require_relative './EXAMPLE_class'

>>>>>>> 9ffa01a5e07e9111969a4d16dd6a5c2e3d63e7b7

class StatTracker

  def self.from_csv(filepath)
    StatTracker.new(filepath)
<<<<<<< HEAD
  end


  def initialize(filepath)
    @filepath = filepath

  end
=======
  end


  def initialize(filepath)
    @games = filepath[:games]
    @teams = filepath[:teams]
    @game_teams = filepath[:game_teams]

  end



>>>>>>> 9ffa01a5e07e9111969a4d16dd6a5c2e3d63e7b7





end
