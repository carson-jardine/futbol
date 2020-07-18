require './test/test_helper'
require './lib/game.rb'


class GamesTest < Minitest::Test


  def test_it_exists
    game1 = Games.new("Games")

    assert_instance_of Games, game1

  end


end
