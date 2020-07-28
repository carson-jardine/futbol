require 'minitest/autorun'
require 'minitest/pride'
require './lib/team_stats'
require 'pry'
class TeamStatsTest < Minitest::Test

  def test_it_exists
  team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")
  assert_instance_of TeamStats, team_stats
  end

  def test_team_stats_have_stats
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")
    assert_equal 9, team_stats.teams.count
    assert_instance_of Array, team_stats.teams
    assert_equal "Atlanta United", team_stats.teams.first.team_name
    assert_equal "DC United", team_stats.teams[3].team_name
  end

  def test_team_info
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")

    result = {"team_id"=>"3", "franchise_id"=>"10", "team_name"=>"Houston Dynamo", "abbreviation"=>"HOU", "link"=>"/api/v1/teams/3"}

    assert_equal result, team_stats.team_info("3")
  end

  def test_get_games_by_team_id_array
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")

    assert_instance_of Array, team_stats.get_games_by_team_id_array("3")
  end

  def test_wins_by_season_count
    skip # this one would be a good candidate for a Mock or Stub
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")

    assert_instance_of Hash, team_stats.wins_by_season_count
  end

  def test_find_season_hash
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")

    assert_instance_of Hash, team_stats.find_season_hash("3")
  end

  def test_games_by_team_id
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")

    assert_instance_of Hash, team_stats.games_by_team_id("3")
  end

  def test_wins_by_team_id
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")

    assert_instance_of Array, team_stats.wins_by_team_id("3")
  end

  def test_team_games_by_season
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")

    assert_instance_of Array, team_stats.team_games_by_season("3")
  end

  def test_find_wins
    skip # this one would be a good candidate for a Mock or Stub
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")
    other_team_by_game = ["3", [away_goals="1", away_team_id="19", date_time="4/30/17", game_id="2016030233", home_goals="3", home_team_id="18", season="20162017", type="Postseason", venue="Allianz Field", venue_link="/api/v1/venues/null"]]

    assert_instance_of Array, team_stats.find_wins(other_team_by_game, "3")
  end

  def test_find_ties
    skip # this one would be a good candidate for a Mock or Stub
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")
    other_team_by_game = ["3", [away_goals="1", away_team_id="19", date_time="4/30/17", game_id="2016030233", home_goals="3", home_team_id="18", season="20162017", type="Postseason", venue="Allianz Field", venue_link="/api/v1/venues/null"]]

    assert_instance_of Array, team_stats.find_ties(other_team_by_game, "3")
  end

  def test_find_other_teams_by_win_percentage
    skip # this one would be a good candidate for a Mock or Stub
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")

    assert_equal [], team_stats.find_other_teams_by_win_percentage(other_teams_by_game, "6")
  end

  def test_find_home_and_away_goals
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")

    assert_equal ["2", "3", "3", "4", "3", "3", "3", "2"], team_stats.find_home_and_away_goals("6")
  end

  def test_find_home_games_in_games
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")

    assert_instance_of Array, team_stats.find_home_games_in_games("6")
  end

  def test_find_away_games_in_games
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")

    assert_instance_of Array, team_stats.find_away_games_in_games("6")
  end

  def test_find_other_teams_by_game
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")

    assert_instance_of Hash, team_stats.find_other_teams_by_game("6")
  end

  def test_find_season_by_win_percentage
    skip # this one would be a good candidate for a Mock or Stub
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")

    assert_equal [], team_stats.find_season_by_win_percentage(other_teams_by_game, "6")
  end

  def test_best_season
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")
    assert_equal "20122012", team_stats.best_season("6")
    assert_equal "20122013", team_stats.best_season("3")
  end

  def test_worst_season
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")
    assert_equal "20122013", team_stats.worst_season("6")
  end

  def test_average_win_percentage
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")
    assert_equal 0.88, team_stats.average_win_percentage("6")
  end

  def test_most_goals_scored
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")
    assert_equal 4, team_stats.most_goals_scored("6")
  end

  def test_fewest_goals_scored
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")
    assert_equal 2, team_stats.fewest_goals_scored("6")
  end

  def test_favorite_opponent
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")
    assert_equal "Sporting Kansas City", team_stats.favorite_opponent("6")
  end

  def test_rival
    team_stats = TeamStats.new("./test/brett_fixtures/fixtures_game_teams.csv", "./test/brett_fixtures/fixtures_games.csv", "./test/brett_fixtures/fixtures_teams.csv")
    assert_equal "Houston Dynamo", team_stats.rival("6")
  end

end
