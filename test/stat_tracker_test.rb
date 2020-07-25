require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'






class StatTrackerTest < Minitest::Test

  def test_it_exists
    stat_tracker = StatTrackerTest.new

    assert_instance_of StatTrackerTest, stat_tracker
  end

  def test_highest_total_score
    stat_tracker = StatTrackerTest.new('./data/games.csv')

    assert_equal [], stat_tracker.highest_total_score
  end


end
