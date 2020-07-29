require 'minitest/autorun'
require 'minitest/pride'
require './lib/league_stats'
require './lib/helper_methods'

class LeagueStatsTest < Minitest::Test
  def test_it_exists
    league_stats = LeagueStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_instance_of LeagueStats, league_stats
  end


  def test_league_stats_has_league_stats_game_teams
    league_stats = LeagueStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal 8, league_stats.game_teams.count
    assert_instance_of Array, league_stats.game_teams
    assert_equal "LOSS", league_stats.game_teams.first.result
  end

  def test_league_stats_has_league_stats_games
    league_stats = LeagueStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal 7, league_stats.games.count
    assert_instance_of Array, league_stats.games
    assert_equal "/api/v1/venues/null", league_stats.games.first.venue_link
  end

  def test_league_stats_has_league_stats_teams
    league_stats = LeagueStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal 8, league_stats.teams.count
    assert_instance_of Array, league_stats.teams
    assert_equal "Mercedes-Benz Stadium", league_stats.teams.first.stadium
  end

  def test_all_the_goals
    league_stats = LeagueStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    game_teams1 = GameTeams.new({:game_id => "2012030221", :team_id => "1", :hoa => "away", :result => "LOSS", :settled_in => "OT", :head_coach => "John Tortorella", :goals => "2", :shots => "8", :tackles => "44", :pim => "8", :powerplayopportunities => "3", :powerplaygoals => "0", :faceoffwinpercentage => "44.8", :giveaways => "17", :takeaways => "7"})
    game_teams2 = GameTeams.new({:game_id => "2013030176", :team_id => "25", :hoa => "home", :result => "WIN", :settled_in => "REG", :head_coach => "Lindy Ruff", :goals => "3", :shots => "6", :tackles => "40", :pim => "5", :powerplayopportunities => "1", :powerplaygoals => "8", :faceoffwinpercentage => "49.4", :giveaways => "13", :takeaways => "9"})
    game_teams = [game_teams1, game_teams2]
    teams_by_id = HelperMethods.find_teams_by_team_id(game_teams)

    assert_equal ({1=>2.0, 25=>3.0}), league_stats.all_the_goals(teams_by_id)
  end

  def test_find_home_games
    league_stats = LeagueStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    game_teams1 = GameTeams.new({:game_id => "2012030221", :team_id => "1", :hoa => "away", :result => "LOSS", :settled_in => "OT", :head_coach => "John Tortorella", :goals => "2", :shots => "8", :tackles => "44", :pim => "8", :powerplayopportunities => "3", :powerplaygoals => "0", :faceoffwinpercentage => "44.8", :giveaways => "17", :takeaways => "7"})
    game_teams2 = GameTeams.new({:game_id => "2013030176", :team_id => "25", :hoa => "home", :result => "WIN", :settled_in => "REG", :head_coach => "Lindy Ruff", :goals => "3", :shots => "6", :tackles => "40", :pim => "5", :powerplayopportunities => "1", :powerplaygoals => "8", :faceoffwinpercentage => "49.4", :giveaways => "13", :takeaways => "9"})
    game_teams = [game_teams1, game_teams2]

    assert_instance_of Array, league_stats.find_home_games(game_teams)
  end

  def test_find_away_games
    league_stats = LeagueStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    game_teams1 = GameTeams.new({:game_id => "2012030221", :team_id => "1", :hoa => "away", :result => "LOSS", :settled_in => "OT", :head_coach => "John Tortorella", :goals => "2", :shots => "8", :tackles => "44", :pim => "8", :powerplayopportunities => "3", :powerplaygoals => "0", :faceoffwinpercentage => "44.8", :giveaways => "17", :takeaways => "7"})
    game_teams2 = GameTeams.new({:game_id => "2013030176", :team_id => "25", :hoa => "home", :result => "WIN", :settled_in => "REG", :head_coach => "Lindy Ruff", :goals => "3", :shots => "6", :tackles => "40", :pim => "5", :powerplayopportunities => "1", :powerplaygoals => "8", :faceoffwinpercentage => "49.4", :giveaways => "13", :takeaways => "9"})
    game_teams = [game_teams1, game_teams2]

    assert_instance_of Array, league_stats.find_away_games(game_teams)
  end

  def test_count_of_teams
    league_stats = LeagueStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal 8, league_stats.count_of_teams
  end

  def test_best_offense
    league_stats = LeagueStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal "FC Dallas", league_stats.best_offense
  end

  def test_worst_offense
    league_stats = LeagueStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal "Orlando City SC", league_stats.worst_offense
  end

  def test_highest_scoring_visitor
    league_stats = LeagueStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal "Houston Dynamo", league_stats.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    league_stats = LeagueStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal "FC Dallas", league_stats.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    league_stats = LeagueStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal "Orlando City SC", league_stats.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    league_stats = LeagueStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal "Houston Dynamo", league_stats.lowest_scoring_home_team
  end

  def test_count_of_teams
    league_stats = LeagueStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")
    assert_equal 32, league_stats.count_of_teams
  end

  def test_best_offense
    league_stats = LeagueStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")
    assert_equal "Reign FC", league_stats.best_offense
  end

  def test_worst_offense
    league_stats = LeagueStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")
    assert_equal "Utah Royals FC", league_stats.worst_offense
  end

  def test_highest_scoring_visitor
    league_stats = LeagueStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")
    assert_equal "FC Dallas", league_stats.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    league_stats = LeagueStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")
    assert_equal "Reign FC", league_stats.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    league_stats = LeagueStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")
    assert_equal "San Jose Earthquakes", league_stats.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    league_stats = LeagueStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")
    assert_equal "Utah Royals FC", league_stats.lowest_scoring_home_team
  end

end
