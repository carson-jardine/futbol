require 'minitest/autorun'
require 'minitest/pride'
require './lib/season_stats'

class SeasonStatsTest < Minitest::Test

  def test_it_exists
    season_stats = SeasonStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    assert_instance_of SeasonStats, season_stats
  end

  def test_it_exists #if csv is different
    season_stats = SeasonStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    assert_instance_of SeasonStats, season_stats
  end

  def test_it_exists #if csv is different
    season_stats = SeasonStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    assert_instance_of SeasonStats, season_stats
  end

  def test_season_stats_has_season_stats_game_teams
    season_stats = SeasonStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    assert_equal 8, season_stats.game_teams.count
    assert_instance_of Array, season_stats.game_teams
    assert_equal "LOSS", season_stats.game_teams.first.result
  end

  def test_season_stats_has_season_stats_games
    season_stats = SeasonStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    assert_equal 7, season_stats.games.count
    assert_instance_of Array, season_stats.games
    assert_equal "/api/v1/venues/null", season_stats.games.first.venue_link
  end

  def test_season_stats_has_season_stats_teams
    season_stats = SeasonStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    assert_equal 8, season_stats.teams.count
    assert_instance_of Array, season_stats.teams
    assert_equal "Mercedes-Benz Stadium", season_stats.teams.first.stadium
  end

  def test_game_teams_has_attributes_via_game_id
    season_stats = SeasonStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    end_result = season_stats.game_teams_find_by_game_id(2012030221)

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
    season_stats = SeasonStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    end_result = season_stats.game_teams_find_by_game_id(2123432423412341)

    assert_nil end_result
  end

  def test_games_has_attributes_via_game_id
    season_stats = SeasonStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    end_result = season_stats.games_find_by_game_id(2012030221)

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
    season_stats = SeasonStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    end_result = season_stats.games_find_by_game_id(2123432423412341)

    assert_nil end_result
  end

  def test_teams_has_attributes_via_team_id
    season_stats = SeasonStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    end_result = season_stats.teams_find_by_team_id(1)
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
    season_stats = SeasonStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    end_result = season_stats.teams_find_by_team_id(2123432423412341)

    assert_nil end_result
  end

# #SEASON STATS
#
#   #Name of the Coach with the best win percentage for the season	String
#
  def test_winningest_coach
    season_stats = SeasonStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    assert_equal "Claude Julien", season_stats.winningest_coach
  end
#
#
#   #Name of the Coach with the worst win percentage for the season	String
  def test_worst_coach
    season_stats = SeasonStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    assert_equal "John Tortorella", season_stats.worst_coach
  end
#
#
#   #Name of the Team with the best ratio of shots to goals for the season	String
  def test_most_accurate_team
    season_stats = SeasonStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    assert_equal "FC Dallas", season_stats.most_accurate_team
  end
#
#
#   #Name of the Team with the worst ratio of shots to goals for the season	String
  def test_least_accurate_team
    season_stats = SeasonStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    assert_equal "Orlando City SC", season_stats.least_accurate_team
  end
#
#
#   #Name of the Team with the most tackles in the season	String
  def test_most_tackles
    season_stats = SeasonStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    assert_equal "FC Dallas", season_stats.most_tackles
  end
#
#
#   #Name of the Team with the fewest tackles in the season	String
  def test_fewest_tackles
    season_stats = SeasonStats.new("./test/fixtures/fixtures_game_teams.csv", "./test/fixtures/fixtures_games.csv", "./test/fixtures/fixtures_teams.csv")

    assert_equal "Orlando City SC", season_stats.fewest_tackles
  end

end
