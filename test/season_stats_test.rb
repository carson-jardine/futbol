require 'minitest/autorun'
require 'minitest/pride'
require './lib/season_stats'
class SeasonStatsTest < Minitest::Test

  def test_it_exists
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")
    assert_instance_of SeasonStats, season_stats
  end

  def test_find_this_season
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_instance_of Array, season_stats.find_this_season("20122013")
  end

  def test_find_games_by_game_id
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    this_season= season_stats.find_this_season("20122013")
    assert_equal ["2012030223", "2012030224", "2012030225", "2012030311", "2012030312"], season_stats.find_games_by_game_id(this_season)
  end

  def test_find_game_list
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    game_teams1 = GameTeams.new({:game_id => "2012030221", :team_id => "1", :hoa => "away", :result => "LOSS", :settled_in => "OT", :head_coach => "John Tortorella", :goals => "2", :shots => "8", :tackles => "44", :pim => "8", :powerplayopportunities => "3", :powerplaygoals => "0", :faceoffwinpercentage => "44.8", :giveaways => "17", :takeaways => "7"})
    game_teams2 = GameTeams.new({:game_id => "2013030176", :team_id => "25", :hoa => "home", :result => "WIN", :settled_in => "REG", :head_coach => "Lindy Ruff", :goals => "3", :shots => "6", :tackles => "40", :pim => "5", :powerplayopportunities => "1", :powerplaygoals => "8", :faceoffwinpercentage => "49.4", :giveaways => "13", :takeaways => "9"})
    game_teams = [game_teams1, game_teams2]
    this_season = season_stats.find_this_season("20122012")
    game_teams_by_id = season_stats.find_teams_by_game_id(game_teams)
    this_season_game_ids = season_stats.find_games_by_game_id(this_season)
    assert_instance_of Array, season_stats.find_game_list(game_teams_by_id, this_season_game_ids)
  end

  def test_find_teams_by_game_id
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    game_teams1 = GameTeams.new({:game_id => "2012030221", :team_id => "1", :hoa => "away", :result => "LOSS", :settled_in => "OT", :head_coach => "John Tortorella", :goals => "2", :shots => "8", :tackles => "44", :pim => "8", :powerplayopportunities => "3", :powerplaygoals => "0", :faceoffwinpercentage => "44.8", :giveaways => "17", :takeaways => "7"})
    game_teams2 = GameTeams.new({:game_id => "2013030176", :team_id => "25", :hoa => "home", :result => "WIN", :settled_in => "REG", :head_coach => "Lindy Ruff", :goals => "3", :shots => "6", :tackles => "40", :pim => "5", :powerplayopportunities => "1", :powerplaygoals => "8", :faceoffwinpercentage => "49.4", :giveaways => "13", :takeaways => "9"})
    game_teams = [game_teams1, game_teams2]
    assert_instance_of Hash, season_stats.find_teams_by_game_id(game_teams)
  end

  def test_find_team_and_accuracy
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    game_teams1 = GameTeams.new({:game_id => "2012030221", :team_id => "1", :hoa => "away", :result => "LOSS", :settled_in => "OT", :head_coach => "John Tortorella", :goals => "2", :shots => "8", :tackles => "44", :pim => "8", :powerplayopportunities => "3", :powerplaygoals => "0", :faceoffwinpercentage => "44.8", :giveaways => "17", :takeaways => "7"})
    game_teams2 = GameTeams.new({:game_id => "2013030176", :team_id => "25", :hoa => "home", :result => "WIN", :settled_in => "REG", :head_coach => "Lindy Ruff", :goals => "3", :shots => "6", :tackles => "40", :pim => "5", :powerplayopportunities => "1", :powerplaygoals => "8", :faceoffwinpercentage => "49.4", :giveaways => "13", :takeaways => "9"})
    game_teams = [game_teams1, game_teams2]
    teams_by_id = HelperMethods.find_teams_by_team_id(game_teams)
    assert_equal ({1=>0.25, 25=>0.5}), season_stats.find_team_and_accuracy(teams_by_id)
  end

  def test_find_team_and_tackles
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    game_teams1 = GameTeams.new({:game_id => "2012030221", :team_id => "1", :hoa => "away", :result => "LOSS", :settled_in => "OT", :head_coach => "John Tortorella", :goals => "2", :shots => "8", :tackles => "44", :pim => "8", :powerplayopportunities => "3", :powerplaygoals => "0", :faceoffwinpercentage => "44.8", :giveaways => "17", :takeaways => "7"})
    game_teams2 = GameTeams.new({:game_id => "2013030176", :team_id => "25", :hoa => "home", :result => "WIN", :settled_in => "REG", :head_coach => "Lindy Ruff", :goals => "3", :shots => "6", :tackles => "40", :pim => "5", :powerplayopportunities => "1", :powerplaygoals => "8", :faceoffwinpercentage => "49.4", :giveaways => "13", :takeaways => "9"})
    game_teams = [game_teams1, game_teams2]
    teams_by_id = HelperMethods.find_teams_by_team_id(game_teams)
    assert_equal ({1=>44, 25=>40}), season_stats.find_team_and_tackles(teams_by_id)
  end

  def test_find_coach_and_wins
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    game1 = Game.new({:game_id => "17", :season => "6", :type => "Regular Season", :date_time => "7/19/2020", :away_team_id => "5", :home_team_id => "2", :away_goals => "3", :home_goals => "4", :venue => "Phil's House", :venue_link => "null" })
    game2 = Game.new({:game_id => "18", :season => "7", :type => "PostSeason", :date_time => "7/20/2020", :away_team_id => "6", :home_team_id => "3", :away_goals => "4", :home_goals => "5", :venue => "Sean's House", :venue_link => "null" })
    games = [game1, game2]
    coach_games_results = {}
    games_grouped_by_season = games.group_by { |game| game.season }
    season_games = games_grouped_by_season.map {|season, game_grouped_by_season| game_grouped_by_season.find_all { |season_game| season_game.season == "2012012" } }.flatten
    this_season_games = season_games.group_by { |season_game| season_game.season }
    season_games2 = this_season_games.map {|season, game| game.map { |x|  x.game_id } }.flatten
    coach_games = season_stats.find_coach_games(season_games2)
    coach_games.each { |coach_name, game_results| coach_games_results[coach_name] = game_results }
    assert_instance_of Array, season_stats.find_coach_and_wins(coach_games_results)
  end

  def test_find_head_coach_best_worst
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    game_teams1 = GameTeams.new({:game_id => "2012030221", :team_id => "1", :hoa => "away", :result => "LOSS", :settled_in => "OT", :head_coach => "John Tortorella", :goals => "2", :shots => "8", :tackles => "44", :pim => "8", :powerplayopportunities => "3", :powerplaygoals => "0", :faceoffwinpercentage => "44.8", :giveaways => "17", :takeaways => "7"})
    game_teams2 = GameTeams.new({:game_id => "2013030176", :team_id => "25", :hoa => "home", :result => "WIN", :settled_in => "REG", :head_coach => "Lindy Ruff", :goals => "3", :shots => "6", :tackles => "40", :pim => "5", :powerplayopportunities => "1", :powerplaygoals => "8", :faceoffwinpercentage => "49.4", :giveaways => "13", :takeaways => "9"})
    game_teams = [game_teams1, game_teams2]
    game1 = Game.new({:game_id => "17", :season => "6", :type => "Regular Season", :date_time => "7/19/2020", :away_team_id => "5", :home_team_id => "2", :away_goals => "3", :home_goals => "4", :venue => "Phil's House", :venue_link => "null" })
    game2 = Game.new({:game_id => "18", :season => "7", :type => "PostSeason", :date_time => "7/20/2020", :away_team_id => "6", :home_team_id => "3", :away_goals => "4", :home_goals => "5", :venue => "Sean's House", :venue_link => "null" })
    games = [game1, game2]
    the_season = "20122013"
    flag = "LOSS"
    assert_instance_of Array, season_stats.find_head_coach_best_worst(games, game_teams, the_season, flag)
  end

  def test_it_exists_with_fixtures
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_instance_of SeasonStats, season_stats
  end

  def test_winningest_coach_with_fixtures
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal "Claude Julien", season_stats.winningest_coach("20122013")
    assert_equal "Claude Julien", season_stats.winningest_coach("20122012")
  end

  def test_worst_coach_with_fixtures
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal "John Tortorella", season_stats.worst_coach("20122013")
    assert_equal "John Tortorella", season_stats.worst_coach("20122012")
  end

  def test_most_accurate_team_with_fixtures
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal "FC Dallas", season_stats.most_accurate_team("20122013")
    assert_equal "FC Dallas", season_stats.most_accurate_team("20122012")
  end

  def test_least_accurate_team_with_fixtures
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal "Houston Dynamo", season_stats.least_accurate_team("20122013")
    assert_equal "Houston Dynamo", season_stats.least_accurate_team("20122012")
  end

  def test_most_tackles_with_fixtures
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal "Houston Dynamo", season_stats.most_tackles("20122013")
    assert_equal "FC Dallas", season_stats.most_tackles("20122012")
  end

  def test_fewest_tackles_with_fixtures
    season_stats = SeasonStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal "FC Dallas", season_stats.fewest_tackles("20122013")
    assert_equal "Houston Dynamo", season_stats.fewest_tackles("20122012")
  end

  def test_winningest_coach
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")
    assert_equal "Claude Julien", season_stats.winningest_coach("20132014")
    assert_equal "Alain Vigneault", season_stats.winningest_coach("20142015")
  end

  def test_worst_coach
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")
    assert_equal "Peter Laviolette", season_stats.worst_coach("20132014")
    assert_equal "Ted Nolan", season_stats.worst_coach("20142015")
  end

  def test_most_accurate_team
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")
    assert_equal "Real Salt Lake", season_stats.most_accurate_team("20132014")
    assert_equal "Toronto FC", season_stats.most_accurate_team("20142015")
  end

  def test_least_accurate_team
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")
    assert_equal "New York City FC", season_stats.least_accurate_team("20132014")
    assert_equal "Columbus Crew SC", season_stats.least_accurate_team("20142015")
  end

  def test_most_tackles
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")
    assert_equal "FC Cincinnati", season_stats.most_tackles("20132014")
    assert_equal "Seattle Sounders FC", season_stats.most_tackles("20142015")
  end

  def test_fewest_tackles
    season_stats = SeasonStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")
    assert_equal "Atlanta United", season_stats.fewest_tackles("20132014")
    assert_equal "Orlando City SC", season_stats.fewest_tackles("20142015")
  end
end
