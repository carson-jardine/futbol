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

  def test_it_exists #if csv is different
    league_stats = LeagueStats.new("./test/fixtures/fixtures_teams.csv")

    assert_instance_of LeagueStats, league_stats
  end

  def test_it_exists #if csv is different
    league_stats = LeagueStats.new("./test/fixtures/fixtures_games.csv")

    assert_instance_of LeagueStats, league_stats
  end

  def test_league_stats_has_league_stats_game_teams
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv")

    assert_equal 6, league_stats.game_teams.count
    assert_instance_of Array, league_stats.game_teams
    assert_equal "LOSS", league_stats.game_teams.first.result
  end

  def test_league_stats_has_league_stats_teams
    league_stats = LeagueStats.new("./test/fixtures/fixtures_teams.csv")

    assert_equal 6, league_stats.teams.count
    assert_instance_of Array, league_stats.teams
    assert_equal "Mercedes-Benz Stadium", league_stats.teams.first.stadium
  end

  def test_league_stats_has_league_stats_games
    league_stats = LeagueStats.new("./test/fixtures/fixtures_games.csv")

    assert_equal 7, league_stats.games.count
    assert_instance_of Array, league_stats.games
    assert_equal "/api/v1/venues/null", league_stats.games.first.venue_link
  end

  def test_it_can_find_game_teams_game_id
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv")

    end_result = league_stats.game_teams_find_by_game_id(2012030221)

    assert_instance_of GameTeams, end_result
    assert_equal "John Tortorella", end_result.head_coach
    assert_equal 2012030221, end_result.game_id
  end

  def test_returns_nil_when_no_find_match_game_teams
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv")

    end_result = league_stats.game_teams_find_by_game_id(2123432423412341)

    assert_nil end_result
  end

  def test_it_can_find_teams_game_id
    league_stats = LeagueStats.new("./test/fixtures/fixtures_teams.csv")

    end_result = league_stats.teams_find_by_team_id(1)

    assert_instance_of Teams, end_result
    assert_equal "ATL", end_result.abbreviation
    assert_equal 1, end_result.team_id
  end

  def test_returns_nil_when_no_find_match_teams
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv")

    end_result = league_stats.teams_find_by_team_id(2123432423412341)

    assert_nil end_result
  end

  def test_it_can_find_games_game_id
    league_stats = LeagueStats.new("./test/fixtures/fixtures_games.csv")

    end_result = league_stats.games_find_by_game_id(2012030221)

    assert_instance_of Games, end_result
    assert_equal "5/16/13", end_result.date_time
    assert_equal 2012030221, end_result.game_id
  end

  def test_returns_nil_when_no_find_match_games
    league_stats = LeagueStats.new("./test/fixtures/fixtures_games.csv")

    end_result = league_stats.games_find_by_game_id(2123432423412341)

    assert_nil end_result
  end

# 	Total number of teams in the data. INTEGER
  def test_count_of_teams
    league_stats = LeagueStats.new("./test/fixtures/fixtures_teams.csv")

    assert_equal 6, league_stats.count_of_teams
  end
#
#  Name of the team with the highest average number of goals scored per game across all seasons.  STRING
  def test_best_offense
    game_teams_info = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv")
    teams_info = LeagueStats.new("./test/fixtures/fixtures_teams.csv")
    games_info = LeagueStats.new("./test/fixtures/fixtures_games.csv")

    league_stats = [game_teams_info, teams_info, games_info]

    assert_equal "FC Dallas", teams_info.best_offense
  end
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
