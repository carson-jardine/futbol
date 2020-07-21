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

  # def games_by_season
  #   season_by_id =
  #   games_by_season = {}
  #     season_by_id = @games.group_by do |game|
  #       game.season
  #     end
  #     season_by_id
  #
  def best_season
    

  end
  #get all games played in a season by team id
  #get the resiult of each game
  #get win percentage for each season by dividing wins by total number of games.
  #return highest win percentage
















end
