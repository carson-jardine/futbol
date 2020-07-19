
require_relative './helper_class'




class StatTracker

  def self.from_csv(filepath)
    StatTracker.new(filepath)

  end

  def initialize(filepath)
    @games = filepath[:games]
    @teams = filepath[:teams]
    @game_teams = filepath[:game_teams]

  end

  








# #LEAGUE STATS
#
# # 	Total number of teams in the data.  STRING INTEGER
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
