require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_stats'
require 'pry'

class GameStatsTest < Minitest::Test

  def test_it_exists
    game_stats = GameStats.new("./test/fixtures/games.csv")

    assert_instance_of GameStats, game_stats
  end

  def test_game_stats_has_games
    game_stats = GameStats.new("./test/fixtures/games.csv")

    assert_equal 6, game_stats.games.count
  end

  def test_it_can_find_game_by_id
    game_stats = GameStats.new("./test/fixtures/games.csv")

    game = game_stats.find_by_id(2012030221)

    assert_instance_of Game, game
    assert_equal 2012030221, game.game_id
    assert_equal 20122013, game.season
    assert_equal "Postseason", game.type
    assert_equal "5/16/13", game.date_time
    assert_equal 3, game.away_team_id
    assert_equal 6, game.home_team_id
    assert_equal 2, game.away_goals
    assert_equal 3, game.home_goals
    assert_equal "Toyota Stadium", game.venue
    assert_equal "/api/v1/venues/null", game.venue_link
  end

  def test_it_returns_nil_when_no_id_match
    game_stats = GameStats.new("./test/fixtures/games.csv")

    game = game_stats.find_by_id(1)

    assert_nil game
  end

  def test_it_can_give_highest_total_score
    game_stats = GameStats.new("./test/fixtures/games.csv")

    assert_equal 6, game_stats.highest_total_score
  end

  def test_it_can_give_lowest_total_score
    game_stats = GameStats.new("./test/fixtures/games.csv")

    assert_equal 3, game_stats.lowest_total_score
  end

  def test_it_can_give_percentage_home_wins
    game_stats = GameStats.new("./test/fixtures/games.csv")

    assert_equal 66.67, game_stats.percentage_home_wins(6)
  end

end
