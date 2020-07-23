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

  def get_games_by_id(game_teams)
    game_teams.group_by do |game_team|
      game_team.game_id
    end
  end

  def get_games_by_season_id(games)
    games.group_by do |game|
      game.season
    end
  end


#TEAM STATS
  def team_info(team_id)
    teams.find { |team| team.team_id == team_id }
  end

  def games_by_season
    seasons = games.group_by do |game|
      game.season
    end
  end

# Season with the highest win percentage for a team.
  def best_season(id)
    games_id_by_season_id = []
    games_id_by_team_id = []
    games_by_team_id = []
    win_games = []
    season_ids = []
    # First we need to get all the games that were played by this team
    game_teams.group_by do |game_team|
      if game_team.team_id == id
        games_by_team_id << game_team
      end
    end


    # Then we group them into a hash where the key => game_id and the value => game_info
    games_by_game_id = get_games_by_id(games_by_team_id)


    games_by_season_id = get_games_by_season_id(games)
    games_by_season_id.each do |game_by_season_id|
      season_ids << game_by_season_id[0]
    end

    binding.pry
    # games_by_game_id.find_all do |game_by_game_id|
    #   game_by_game_id
    #

    games.find_all do |game|
      if games_id_by_team_id.any?(game.game_id) == true
        games_id_by_season_id << game
      end
    end
    team_games_by_season = games_id_by_season_id.group_by do |games|
      games.season
    end
    team_games_by_season.map do |team_season|
      team_season.each do |game|

        binding.pry
      end
    end
  end

end

# SOMETHING ELSE GOES HERE.find_all do |game_by_team_id|
#   if game_by_team_id.result == "WIN"
#     win_games << game_by_team_id
#   end
# end
# percentage_wins = win_games.count.to_f / games_by_team_id.count.to_f

      #I now have all the game ids of one team id.

      #Now I need to get all of those games matched with the corresponding season and count them.
      #Then out of those total up the games that where wins and divide by total x 100
      # return the season with the best percentage.













  #get allgames played in a season by team id
  #get the resiult of each game
  #get win percentage for each season by dividing wins by total number ofgames.
  #return highest wi
