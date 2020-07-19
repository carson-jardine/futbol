require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_stats'

class GameStatsTest < Minitest::Test

  def test_it_exists
    game_stats = GameStats.new("./test/fixtures/games.csv")

    assert_instance_of GameStats, game_stats
  end

  def test_game_stats_has_games
    game_stats = GameStats.new("./test/fixtures/games.csv")

    assert_equal 2, game_stats.games.count
  end

  # def test_it_can_find_game_by_id
  #   game_stats = GameStats.new("./test/fixtures/games.csv")
  #
  #   result = game_stats.find_by_id(1)
  #
  #   assert_instance_of Game,

end
