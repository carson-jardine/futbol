require 'minitest/autorun'
require 'minitest/pride'
# require_relative './games.csv'
# require_relative './teams.csv'
# require_relative './game_teams.csv'
require './lib/league'
require './lib/league_stats'

class LeagueStatsTest < Minitest::Test

  def test_it_exists
    league_stats = LeagueStatsTest.new("filepath")

    assert_instance_of LeagueStatsTest, league_stats
  end


# # 	Total number of teams in the data. INTEGER
#   def test_count_of_teams
#     league_stats = LeagueStatsTest.new
#
#     assert_equals LeagueStatsTest, league_stats
#   end
# #
# #  Name of the team with the highest average number of goals scored per game across all seasons.  STRING
#   def test_best_offense
#
#   end
#
#  # Name of the team with the lowest average number of goals scored per game across all seasons.  STRING
#   def test_worst_offense
#
#   end
#
# # Name of the team with the highest average score per game across all seasons when they are away.  STRING
#   def test_highest_scoring_visitor
#
#   end
#
# # Name of the team with the highest average score per game across all seasons when they are home.  STRING
#   def test_highest_scoring_home_team
#
#   end
#
#  # Name of the team with the lowest average score per game across all seasons when they are a visitor.  STRING
#   def test_lowest_scoring_visitor
#
#   end
#
#  # 	Name of the team with the lowest average score per game across all seasons when they are at home.  STRING
#   def test_lowest_scoring_home_team
#
#   end

end
