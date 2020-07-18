

class League

  def initialize(filepath)
    @games = filepath[:games]
    @teams = filepath[:teams]
    @game_teams = filepath[:game_teams]

  end
end
