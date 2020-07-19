require './test/test_helper'
require './lib/game.rb'


class GamesTest < Minitest::Test


  def test_it_exists
    game = Game.new({:game_id => "17", :season => "6",
       :type => "Regular Season", :date_time => "7/19/2020",
        :away_team_id => "5", :home_team_id => "2", :away_goals => "3",
         :home_goals => "4", :venue => "Phil's House",
          :venue_link => "null" })

    assert_instance_of Game, game

  end

  def test_it_has_attributes
    game = Game.new({:game_id => "17", :season => "6",
       :type => "Regular Season", :date_time => "7/19/2020",
        :away_team_id => "5", :home_team_id => "2", :away_goals => "3",
         :home_goals => "4", :venue => "Phil's House",
          :venue_link => "null" })

    assert_equal 17, game.game_id
    assert_equal 6, game.season
    assert_equal "Regular Season", game.type
    assert_equal "7/19/2020", game.date_time
    assert_equal 5, game.away_team_id
    assert_equal 2, game.home_team_id
    assert_equal 3, game.away_goals
    assert_equal 4, game.home_goals
    assert_equal "Phil's House", game.venue
    assert_equal "null", game.venue_link
  end

end
