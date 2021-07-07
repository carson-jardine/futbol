require 'minitest/autorun'
require 'minitest/pride'
require './lib/season_stats'

class SeasonStatsTest < Minitest::Test

  def test_it_exists
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    assert_instance_of SeasonStats, season_stats
  end

  def test_it_exists_with_fixtures
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")

    assert_instance_of SeasonStats, season_stats
  end

# #SEASON STATS

  def test_winningest_coach_with_fixtures
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")

    assert_equal "Claude Julien", season_stats.winningest_coach(20122013)
  end

  def test_winningest_coach_diff_season_with_fixtures
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")

    assert_equal "Claude Julien", season_stats.winningest_coach(20122012)
  end

  def test_worst_coach_with_fixtures
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")

    assert_equal "John Tortorella", season_stats.worst_coach(20122013)
  end

  def test_worst_coach_diff_season_with_fixtures
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")

    assert_equal "John Tortorella", season_stats.worst_coach(20122012)
  end

  def test_most_accurate_team_with_fixtures
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")

    assert_equal "FC Dallas", season_stats.most_accurate_team(20122013)
  end

  def test_most_accurate_team_diff_season_with_fixtures
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")

    assert_equal "FC Dallas", season_stats.most_accurate_team(20122012)
  end

  def test_least_accurate_team_with_fixtures
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")

    assert_equal "Houston Dynamo", season_stats.least_accurate_team(20122013)
  end

  def test_least_accurate_team_diff_season_with_fixtures
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")

    assert_equal "Houston Dynamo", season_stats.least_accurate_team(20122012)
  end
  #
  def test_most_tackles_with_fixtures
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")

    assert_equal "Houston Dynamo", season_stats.most_tackles(20122013)
  end

  def test_most_tackles_diff_season_with_fixtures
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")

    assert_equal "FC Dallas", season_stats.most_tackles(20122012)
  end

  def test_fewest_tackles_with_fixtures
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")

    assert_equal "FC Dallas", season_stats.fewest_tackles(20122013)
  end

  def test_fewest_tackles_diff_season_with_fixtures
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")

    assert_equal "Houston Dynamo", season_stats.fewest_tackles(20122012)
  end

# SEASON STATS with real numbers

  def test_winningest_coach
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    assert_instance_of String, season_stats.winningest_coach(20122013)
  end

  def test_winningest_coach_diff_season
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    assert_instance_of String, season_stats.winningest_coach(20142015)
  end

  def test_worst_coach
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    assert_instance_of String, season_stats.worst_coach(20122013)
  end

  def test_worst_coach_diff_season
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    assert_instance_of String, season_stats.worst_coach(20142015)
  end

  def test_most_accurate_team
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    assert_instance_of String, season_stats.most_accurate_team(20122013)
  end

  def test_most_accurate_team_diff_season
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    assert_instance_of String, season_stats.most_accurate_team(20142015)
  end

  def test_least_accurate_team
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    assert_instance_of String, season_stats.least_accurate_team(20122013)
  end

  def test_least_accurate_team_diff_season
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    assert_instance_of String, season_stats.least_accurate_team(20142015)
  end

  def test_most_tackles
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    assert_instance_of String, season_stats.most_tackles(20122013)
  end

  def test_most_tackles_diff_season
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    assert_instance_of String, season_stats.most_tackles(20142015)
  end

  def test_fewest_tackles
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    assert_instance_of String, season_stats.fewest_tackles(20122013)
  end

  def test_fewest_tackles_diff_season
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    assert_instance_of String, season_stats.fewest_tackles(20142015)
  end

end
