require 'minitest/autorun'
require 'minitest/pride'
require './lib/team_stats'
require 'pry'

class TeamStatsTest < Minitest::Test

  def test_it_exists
  team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")
  end

  def test_team_stats_have_stats
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")
    assert_equal 8, team_stats.teams.count
    assert_instance_of Array, team_stats.teams

    assert_equal "Atlanta United", team_stats.teams.first.teamname

    assert_equal "DC United", team_stats.teams[3].teamname

  end

  def test_it_can_find_team_info_by_id
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")
    result = team_stats.team_info(3)
    assert_instance_of Hash, result
  end

  def test_it_can_find_games_by_team_id
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")

    assert_instance_of Array, team_stats.games_by_team_id(3)
  end

  def test_games_by_season
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")
    games_by_team_id_array = team_stats.games_by_team_id(3)
    assert Hash, team_stats.games_by_season
  end

  def test_wins_across_all_seasons
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")
    games_by_team_id_array = team_stats.games_by_team_id(6)
    seasons_hash = team_stats.games_by_season

    assert_equal 7,team_stats.wins_across_all_seasons( 6)
  end

  def test_wins_across_all_seasons_and_wins_by_season
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")
    games_by_team_id_array = team_stats.games_by_team_id(6)
    seasons_hash = team_stats.games_by_season
    team_stats.wins_across_all_seasons(6)

    assert Hash, team_stats.wins_by_season
  end

  def test_wins_by_season_count
    skip
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")
    games_by_team_id_array = team_stats.games_by_team_id(6)
    seasons_hash = team_stats.games_by_season
    wins_by_season =team_stats.wins_across_all_seasons(6)

    assert Hash, team_stats.wins_by_season_count
  end

  def test_best_season
    skip
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")

    assert_equal [], team_stats.best_season(6)
  end








  #
  # def test_get_games_id
  #   skip
  #   team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")
  #   game_id_by_team_id_array = team_stats.games_by_team_id(3)
  #   result = [2012030221, 2012030222, 2012030223, 2014030134, 2014030135, 2014030311, 2014030312, 2014030313, 2014030314]
  #   assert_equal result , team_stats.get_games_id(game_id_by_team_id_array)
  # end
  #
  # def test_group_game_ids_by_season
  #   skip
  #   team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")
  #   game_id_by_team_id_array = [2012030221, 2012030222, 2012030223, 2014030134, 2014030135, 2014030311, 2014030312, 2014030313, 2014030314]
  #   team_stats.games_by_season
  #
  #   assert_equal [], team_stats.get_games_with_season_ids(game_id_by_team_id_array)
  # end

  # def test_it_can_find_season_with_highest_win_percentage
  #   team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")
  #
  #   assert_equal "Season", team_stats.best_season(3)
  # end




  # def test_it_returns_nil_when_no_match
  #   team_stats = TeamStats.new("./test/brett_fixtures/fixtures_teams.csv")
  #
  #
  #   result = merchant_collection.find_by_id(23423423)
  #
  #   assert_nil result
  # end








end
