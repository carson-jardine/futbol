
require 'minitest/autorun'
require 'minitest/pride'
require './lib/helper_methods'
require 'pry'

class HelperMethodsTest < Minitest::Test

  def test_season_stats_has_season_stats_game_teams
    season_stats = HelperMethods.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    assert_equal 14882, season_stats.game_teams.count
    assert_instance_of Array, season_stats.game_teams
    assert_equal "LOSS", season_stats.game_teams.first.result
  end

  def test_season_stats_has_season_stats_games
    season_stats = HelperMethods.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    assert_equal 7441, season_stats.games.count
    assert_instance_of Array, season_stats.games
    assert_equal "/api/v1/venues/null", season_stats.games.first.venue_link
  end

  def test_season_stats_has_season_stats_teams
    season_stats = HelperMethods.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    assert_equal 32, season_stats.teams.count
    assert_instance_of Array, season_stats.teams
    assert_equal "Mercedes-Benz Stadium", season_stats.teams.first.stadium
  end

  # HELPER METHODS

  def test_largest_hash_value
    season_stats = HelperMethods.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    hash = {9 => 999, 5 => 3}

    assert_equal [9, 999], season_stats.largest_hash_value(hash)
  end

  def test_smallest_hash_value
    season_stats = HelperMethods.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    hash = {9 => 999, 5 => 3}

    assert_equal [5, 3], season_stats.smallest_hash_value(hash)
  end

  
end
