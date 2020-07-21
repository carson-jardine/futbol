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
    teams.find { |team| team.team_id == team_id }
  end

  def games_by_season
    seasons = games.group_by do |game|
      game.season
    end
  end

  def best_season(id)

    games_id_by_team_id = []
    games_by_team_id = []
     game_teams.group_by do |game_team|
      if game_team.team_id == (id)
        games_by_team_id << game_team
      end
    end
      games_by_game_id = games_by_team_id.group_by do |game|
        game.game_id
      end
      games_by_game_id.each do |game|
        games_id_by_team_id << game[0]

        #I now have all the game ids of one team id.
        #Now I need to get all of those games matched with the corresponding season and count them.
        #Then out of those total up the games that where wins and divide by total x 100
        # return the season with the best percentage.

      end
  end





end






  #get allgames played in a season by team id
  #get the resiult of each game
  #get win percentage for each season by dividing wins by total number ofgames.
  #return highest wi
