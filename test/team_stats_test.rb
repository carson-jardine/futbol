require 'minitest/autorun'
require 'minitest/pride'
require './lib/team_stats'
require 'pry'

class TeamStatsTest < Minitest::Test

  def test_it_exists
  team_stats = TeamStats.new("./test/fixtures/fixtures_teams.csv")
  assert_instance_of TeamStats, team_stats
  end

  def test_team_stats_have_stats
    team_stats = TeamStats.new("./test/fixtures/fixtures_teams.csv")

    assert_equal 5, team_stats.teams.count
    assert_instance_of Array, team_stats.teams
    assert_equal "Atlanta United", team_stats.teams.first.teamname
    assert_equal "DC United", team_stats.teams[3].teamname

  end

  def test_it_can_find_team_info_by_id
    team_stats = TeamStats.new("./test/fixtures/fixtures_teams.csv")
    result = team_stats.team_info(4)

    assert_instance_of Team, result
    assert_equal "Chicago Fire", result.teamname
    assert_equal 4, result.team_id
    assert_equal 16, result.franchiseid
    assert_equal "CHI", result.abbreviation
    assert_equal "/api/v1/teams/4", result.link
    # binding.pry
  end

  # def test_it_can_get_team_info
  #   team_stats = TeamStats.new("./test/fixtures/fixtures_teams.csv")
  #   result = team_stats.team_info(1)
  #   assert_equal {:team_id => 1, :franchiseid => 23, :teamname => "Atlanta United", :abbreviation => "ATL", :link => "/api/v1/teams/1"}, teamstats.team_info(result)
  #
  #
  # end



  # def test_it_returns_nil_when_no_match
  #   team_stats = TeamStats.new("./test/fixtures/fixtures_teams.csv")
  #
  #
  #   result = merchant_collection.find_by_id(23423423)
  #
  #   assert_nil result
  # end








end
