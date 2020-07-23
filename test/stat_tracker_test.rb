require 'minitest/autorun'
require 'minitest/pride'
require_relative './stat_tracker'
require_relative './games.csv'
require_relative './teams.csv'
require_relative './game_teams.csv'





class StatTrackerTest < Minitest::Test

  def test_it_exists
    stat_tracker = StatTrackerTest.new

    assert_instance_of StatTrackerTest, stat_tracker
  end





end
