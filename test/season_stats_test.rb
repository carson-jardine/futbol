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

  def test_season_stats_has_season_stats_game_teams
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    assert_equal 14882, season_stats.game_teams.count
    assert_instance_of Array, season_stats.game_teams
    assert_equal "LOSS", season_stats.game_teams.first.result
  end

  def test_season_stats_has_season_stats_games
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    assert_equal 7441, season_stats.games.count
    assert_instance_of Array, season_stats.games
    assert_equal "/api/v1/venues/null", season_stats.games.first.venue_link
  end

  def test_season_stats_has_season_stats_teams
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    assert_equal 32, season_stats.teams.count
    assert_instance_of Array, season_stats.teams
    assert_equal "Mercedes-Benz Stadium", season_stats.teams.first.stadium
  end

  def test_game_teams_has_attributes_via_game_id
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

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
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    end_result = season_stats.game_teams_find_by_game_id(2123432423412341)

    assert_nil end_result
  end

  def test_games_has_attributes_via_game_id
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

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
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    end_result = season_stats.games_find_by_game_id(2123432423412341)

    assert_nil end_result
  end

  def test_teams_has_attributes_via_team_id
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    end_result = season_stats.teams_find_by_team_id(1)

    assert_instance_of Team , end_result
    assert_equal 1, end_result.team_id
    assert_equal 23, end_result.franchiseid
    assert_equal "Atlanta United", end_result.teamname
    assert_equal "ATL", end_result.abbreviation
    assert_equal "Mercedes-Benz Stadium", end_result.stadium
    assert_equal "/api/v1/teams/1", end_result.link
  end

  def test_returns_nil_when_no_find_match_teams
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    end_result = season_stats.teams_find_by_team_id(2123432423412341)

    assert_nil end_result
  end

# HELPER METHODS

  def test_largest_hash_value
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    hash = {9 => 999, 5 => 3}

    assert_equal [9, 999], season_stats.largest_hash_value(hash)
  end

  def test_smallest_hash_value
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    hash = {9 => 999, 5 => 3}

    assert_equal [5, 3], season_stats.smallest_hash_value(hash)
  end

  def test_find_win_games
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")

    assert_equal 4, season_stats.find_win_games(season_stats.game_teams).count
  end

  def test_find_lose_games
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")

    assert_equal 4, season_stats.find_lose_games(season_stats.game_teams).count
  end

  def test_find_result_games_with_key_as_game_id
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")

    result_games = season_stats.find_lose_games(season_stats.game_teams)

    assert_equal 4, season_stats.find_result_games_with_key_as_game_id(result_games).count
  end

  def test_find_this_season
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")

    assert_equal 5, season_stats.find_this_season(20122013).count
  end

  def test_find_result_games_this_season
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")

    result_games = season_stats.find_lose_games(season_stats.game_teams)
    result_games_with_key_as_game_id = season_stats.find_result_games_with_key_as_game_id(result_games)
    this_season = season_stats.find_this_season(20122013)

    assert_equal 1, season_stats.find_result_games_this_season(this_season, result_games_with_key_as_game_id).count
  end

  # def test_find_teams_by_team_id
  #   season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
  #
  #   # binding.pry
  #   assert_equal 4, find_teams_by_team_id(season_stats.game_teams.count)
  # end
  #
  # def test_find_teams_by_game_id
  #   season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
  #
  #   assert_equal 5, find_teams_by_game_id(season_stats.game_teams.count)
  # end

#   def test_find_game_list
#     season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
# # binding.pry
#     games_by_game_id = get_teams_by_game_id(season_stats.game_teams)
#     this_season = find_this_season(20122013)
#     games_with_key_as_game_id = find_games_by_game_id(this_season)
#
#     assert_equal 1, season_stats.find_game_list(games_with_key_as_game_id, games_by_game_id).count
#   end
  #
  # def test_find_game_list_with_reduce
  #   season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
  #
  #   assert_equal nil, season_stats.find_game_list_with_reduce(games_with_key_as_game_id, games_by_game_id)
  # end

  # def test_get_teams_by_team_id
  #   season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
  #
  #   assert_equal 4, season_stats.get_teams_by_team_id(season_stats.game_teams).count
  # end
  #
  # def test_get_teams_by_game_id
  #   season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
  #
  #   assert_equal 5, season_stats.get_teams_by_game_id(season_stats.game_teams).count
  # end

  # def test_find_team_and_results
  #   season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
  #
  #   this_season = find_this_season(20122013)
  #   teams_by_id = get_teams_by_team_id(season_stats.game_teams)
  #
  #   assert_equal nil, season_stats.find_team_and_results(teams_by_id, this_season)
  # end

  # def test_find_team_and_accuracy
  #   season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
  #
  #   teams_by_id = get_teams_by_team_id(season_stats.game_teams)
  #
  #   assert_equal nil, season_stats.find_team_and_accuracy(teams_by_id)
  # end

  # def test_find_coach_name
  #   season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
  #
  #   teams_by_id = get_teams_by_team_id(season_stats.game_teams)
  #   team_and_losses = find_team_and_results(teams_by_id, this_season)
  #   worst_coach = largest_hash_value(team_and_losses)[0]
  #   coach_name = find_coach_name(worst_coach)
  #
  #   assert_equal nil, season_stats.find_coach_name(coach_name)
  # end

  # def test_find_team_name
  #   season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
  #
  #   teams_by_id = get_teams_by_team_id(season_stats.game_teams)
  #   team_and_accuracy = find_team_and_accuracy(teams_by_id)
  #   best_team = largest_hash_value(team_and_accuracy)[0]
  #   team_name = find_team_name(best_team)
  #
  #   assert_equal nil, season_stats.find_team_name(team_name)
  # end




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

    assert_instance_of String, season_stats.most_tackles(20122013)
  end

  def test_fewest_tackles
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    assert_instance_of String, season_stats.fewest_tackles(20122013)
  end

  def test_fewest_tackles_diff_season
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    assert_instance_of String, season_stats.fewest_tackles(20122013)
  end

end
