require 'minitest/autorun'
require 'minitest/pride'
require './lib/league_stats'

class LeagueStatsTest < Minitest::Test

  def test_it_exists
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    assert_instance_of LeagueStats, league_stats
  end

  def test_it_exists #if csv is different
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    assert_instance_of LeagueStats, league_stats
  end

  def test_it_exists #if csv is different
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    assert_instance_of LeagueStats, league_stats
  end

  def test_league_stats_has_league_stats_game_teams
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    assert_equal 6, league_stats.game_teams.count
    assert_instance_of Array, league_stats.game_teams
    assert_equal "LOSS", league_stats.game_teams.first.result
  end

  def test_league_stats_has_league_stats_games
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    assert_equal 7, league_stats.games.count
    assert_instance_of Array, league_stats.games
    assert_equal "/api/v1/venues/null", league_stats.games.first.venue_link
  end

  def test_league_stats_has_league_stats_teams
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    assert_equal 6, league_stats.teams.count
    assert_instance_of Array, league_stats.teams
    assert_equal "Mercedes-Benz Stadium", league_stats.teams.first.stadium
  end

  def test_game_teams_has_attributes_via_game_id
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    end_result = league_stats.game_teams_find_by_game_id(2012030221)

    assert_instance_of GameTeams, end_result
    assert_equal 2012030221, end_result.game_id
    assert_equal 3, end_result.team_id
    assert_equal "away", end_result.hoa
    assert_equal "LOSS", end_result.result
    assert_equal "OT", end_result.settled_in
    assert_equal "John Tortorella", end_result.head_coach
    assert_equal 2, end_result.goals
    assert_equal 8, end_result.shots
    assert_equal 44, end_result.tackles
    assert_equal 8, end_result.pim
    assert_equal 3, end_result.powerplayopportunities
    assert_equal 0, end_result.powerplaygoals
    assert_equal 44.8, end_result.faceoffwinpercentage
    assert_equal 17, end_result.giveaways
    assert_equal 7, end_result.takeaways

  end

  def test_returns_nil_when_no_find_match_game_teams
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    end_result = league_stats.game_teams_find_by_game_id(2123432423412341)

    assert_nil end_result
  end

  def test_games_has_attributes_via_game_id
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    end_result = league_stats.games_find_by_game_id(2012030221)

    assert_instance_of Game, end_result
    assert_equal 2012030221, end_result.game_id
    assert_equal 20122013, end_result.season
    assert_equal "Postseason", end_result.type
    assert_equal "5/16/13", end_result.date_time
    assert_equal 3, end_result.away_team_id
    assert_equal 6, end_result.home_team_id
    assert_equal 2, end_result.away_goals
    assert_equal 3, end_result.home_goals
    assert_equal "Toyota Stadium", end_result.venue
    assert_equal "/api/v1/venues/null", end_result.venue_link
  end

  def test_returns_nil_when_no_find_match_games
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    end_result = league_stats.games_find_by_game_id(2123432423412341)

    assert_nil end_result
  end

  def test_teams_has_attributes_via_team_id
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    end_result = league_stats.teams_find_by_team_id(1)
    # require 'pry'; binding.pry
    assert_instance_of Team , end_result
    assert_equal 1, end_result.team_id
    assert_equal 23, end_result.franchiseid
    assert_equal "Atlanta United", end_result.teamname
    assert_equal "ATL", end_result.abbreviation
    assert_equal "Mercedes-Benz Stadium", end_result.stadium
    assert_equal "/api/v1/teams/1", end_result.link
  end

  def test_returns_nil_when_no_find_match_teams
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    end_result = league_stats.teams_find_by_team_id(2123432423412341)

    assert_nil end_result
  end

  # #LEAGUE STATS METHODS
  def test_count_of_teams
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    assert_equal 6, league_stats.count_of_teams
  end

  def test_best_offense
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    assert_equal "FC Dallas", league_stats.best_offense
  end

  def test_worst_offense
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    assert_equal "Houston Dynamo", league_stats.worst_offense
  end

  def test_highest_scoring_visitor
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    assert_equal "Houston Dynamo", league_stats.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    assert_equal "FC Dallas", league_stats.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    assert_equal "FC Dallas", league_stats.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    league_stats = LeagueStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    assert_equal "Houston Dynamo", league_stats.lowest_scoring_home_team
  end

end
