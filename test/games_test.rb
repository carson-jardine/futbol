require 'minitest/autorun'
require 'minitest/pride'
require './lib/games'

class GamesTest < Minitest::Test

  def test_it_exists
    game1 = Games.new({:game_id => "2012030221", :season => "20122013", :type => "Postseason", :date_time => "5/16/13", :away_team_id => "3", :home_team_id => "6", :away_goals => "2", :home_goals => "3", :venue => "Toyota Stadium", :venue_link => "/api/v1/venues/null"})

    assert_instance_of Games, game1
  end

  def test_it_has_attributes
    game1 = Games.new({:game_id => "2012030221", :season => "20122013", :type => "Postseason", :date_time => "5/16/13", :away_team_id => "3", :home_team_id => "6", :away_goals => "2", :home_goals => "3", :venue => "Toyota Stadium", :venue_link => "/api/v1/venues/null"})

    assert_equal 2012030221, game1.game_id
    assert_equal 20122013, game1.season
    assert_equal "Postseason", game1.type
    assert_equal "5/16/13", game1.date_time
    assert_equal 3, game1.away_team_id
    assert_equal 6, game1.home_team_id
    assert_equal 2, game1.away_goals
    assert_equal 3, game1.home_goals
    assert_equal "Toyota Stadium", game1.venue
    assert_equal "/api/v1/venues/null", game1.venue_link
  end


  def test_it_has_different_attributes
    game1 = Games.new({:game_id => "2013020674", :season => "20132014", :type => "Regular Season", :date_time => "1/11/14", :away_team_id => "19", :home_team_id => "23", :away_goals => "1", :home_goals => "2", :venue => "Saputo Stadium", :venue_link => "/api/v1/venues/null"})

    assert_equal 2013020674, game1.game_id
    assert_equal 20132014, game1.season
    assert_equal "Regular Season", game1.type
    assert_equal "1/11/14", game1.date_time
    assert_equal 19, game1.away_team_id
    assert_equal 23, game1.home_team_id
    assert_equal 1, game1.away_goals
    assert_equal 2, game1.home_goals
    assert_equal "Saputo Stadium", game1.venue
    assert_equal "/api/v1/venues/null", game1.venue_link
  end

end
