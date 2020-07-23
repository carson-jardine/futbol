require 'CSV'
require_relative './game'
require_relative './team'
require_relative './game_teams'

class TeamStats
  attr_reader :game_teams,
              :teams,
              :games

  def initialize(filepath1, filepath2, filepath3)
    @game_teams = []
    @games      = []
    @teams      = []
    load_game_teams(filepath1)
    load_games(filepath2)
    load_teams(filepath3)
  end

  def load_game_teams(filepath1)
    CSV.foreach(filepath1, headers: true, header_converters: :symbol) do |data|
      @game_teams << GameTeams.new(data)
    end
  end

  def load_games(filepath2)
    CSV.foreach(filepath2, headers: true, header_converters: :symbol) do |data|
      @games << Game.new(data)
    end
  end

  def load_teams(filepath3)
    CSV.foreach(filepath3, headers: true, header_converters: :symbol) do |data|
      @teams << Team.new(data)
    end
  end

  def team_info(team_id)
    hash = {}
    information = teams.find { |team| team.team_id == team_id }
    hash[:team_id]= information.team_id
    hash[:franchiseid]= information.franchiseid
    hash[:teamname]= information.teamname
    hash[:abbreviation]= information.abbreviation
    hash[:link]= information.link
    hash
  end


  def games_by_season
    seasons = games.group_by do |game|
      game.season
    end
  end

  def games_by_team_id(team_id)
    games_by_team_id_array = []
    game_teams.each do |game_team|
      if game_team.team_id == (team_id)
        games_by_team_id_array << game_team
      end
    end
    games_by_team_id_array
  end

  def get_games_id(games_by_team_id_array)
    game_id_by_team_id_array = []
    games_by_team_id_array.find_all do |game|
      game_id_by_team_id_array << game.game_id
    end
    game_id_by_team_id_array
  end

end
