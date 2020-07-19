require 'minitest/autorun'
require 'minitest/pride'
# require_relative './games.csv'
# require_relative './teams.csv'
# require_relative './game_teams.csv'
require './lib/league_stats'

class LeagueStatsTest < Minitest::Test

  def test_it_exists
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv")


    assert_instance_of LeagueStats, league_stats
  end

  def test_league_stats_has_league_stats
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv")

    assert_equal 5, league_stats.all.count
    assert_instance_of Array, league_stats.all
    assert_equal "LOSS", league_stats.all.first.result
  end

  def test_it_can_find_game_teams_id
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv")

    end_result = league_stats.find_by_game_id(2012030221)

    assert_instance_of GameTeams, end_result
    assert_equal "John Tortorella", end_result.head_coach
    assert_equal 2012030221, end_result.game_id
  end

# 	Total number of teams in the data. INTEGER
  # def test_count_of_teams
  #   league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv")
  #   # require 'pry'; binding.pry
  #   assert_equal LeagueStats, league_stats
  # end
#
#  Name of the team with the highest average number of goals scored per game across all seasons.  STRING
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
