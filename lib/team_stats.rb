require 'CSV'
require_relative './game'
require_relative './team'
require_relative './game_teams'

class TeamStats
  attr_reader :teams
  def initialize(filepath)
    @teams = []
    load_team(filepath)
  end


  def load_team(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @teams << Team.new(data)
    end
  end

  def team_info(team_id)
    @teams.find { |team| team.team_id == team_id }
  end

  









end
