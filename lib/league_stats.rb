require 'CSV'

require_relative './games'
require_relative './teams'
require_relative './game_teams'

class LeagueStats


  def initialize(filepath)
    #yeah, rename the below
    @game_teams_stuff = []
    load_game_teams(filepath)
  end

  def all
    @game_teams_stuff
  end

  def load_game_teams(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @game_teams_stuff << GameTeams.new(data)
    end
  end

  def find_by_game_id(game_id)
    @game_teams_stuff.find do |season_stat|
      # require 'pry'; binding.pry
      season_stat.game_id == game_id
    end
  end
  # #LEAGUE STATS
  #
  # # 	Total number of teams in the data.  INTEGER
  #   def count_of_teams
  #
  #   end
  #
  # #  Name of the team with the highest average number of goals scored per game across all seasons.  STRING
  #   def best_offense
  #
  #   end
  #
  #  # Name of the team with the lowest average number of goals scored per game across all seasons.  STRING
  #   def worst_offense
  #
  #   end
  #
  # # Name of the team with the highest average score per game across all seasons when they are away.  STRING
  #   def highest_scoring_visitor
  #
  #   end
  #
  # # Name of the team with the highest average score per game across all seasons when they are home.  STRING
  #   def highest_scoring_home_team
  #
  #   end
  #
  #  # Name of the team with the lowest average score per game across all seasons when they are a visitor.  STRING
  #   def lowest_scoring_visitor
  #
  #   end
  #
  #  # 	Name of the team with the lowest average score per game across all seasons when they are at home.  STRING
  #   def lowest_scoring_home_team
  #
  #   end



end
