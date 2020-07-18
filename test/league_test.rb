require 'minitest/autorun'
require 'minitest/pride'
# require_relative './games.csv'
# require_relative './teams.csv'
# require_relative './game_teams.csv'
require './lib/league'

class LeagueTest < Minitest::Test

  def test_it_exists
    league = LeagueTest.new("filepath")

    assert_instance_of LeagueTest, league
  end

end
