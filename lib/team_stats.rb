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

  def get_game_teams_by_game_id(game_teams)
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

  # def games_by_season
  #   seasons = games.group_by do |game|
  #     game.season
  #   end
  # end

# Season with the highest win percentage for a team.
  def best_season(id)
    games_id_by_season_id = []
    games_id_by_team_id = []
    games_by_team_id = []
    win_games = []
    games_season_ids = []
    games_to_consider = {}
    games_by_season = {}
    # First we need to get all the games that were played by this team
    game_teams.find_all do |game_team|
      if game_team.team_id == id
        games_by_team_id << game_team
      end
    end
    # Then we group them into a hash where the key => game_id and the value => game_team_info
    game_teams_by_game_id = get_game_teams_by_game_id(games_by_team_id)

    # next we group games into a hash where the key => season_id and the value => games_info
    games_by_season_id = get_games_by_season_id(games)
    # Next, we strip that last hash down to just the season_ids ... for some reason?
    games_by_season_id.each do |game_by_season_id|
      games_season_ids << game_by_season_id[0]
    end
    #now make a hash that has key => game_id and value => game info
    game_teams_by_game_id.find_all do |game_team_by_game_id|
      binding.pry
      if games_season_ids.any?(game_team_by_game_id[0]) == true
        games_to_consider[game_team_by_game_id[0]] = game_team_by_game_id[1].reduce
      end
    end


    ####
    #  What about making a hask with the key => season id and the value => game_id   then somehow replacing that game_id with the game information? or making a new hash with the season id and the game info?
#####
    #next we need to separate these games into a hash with key => season and value => game
    # games_by_season_id.find_all do |game_by_season_id2|
    #   if games_to_consider.key.any?(game_by_season_id2[0]) == true
    #     games_by_season[game_by_season_id2[0]] = game_by_season_id2[1]
    #   end
    # end


    # games_by_game_id.each do |game_by_game_id|
    #   games_game_ids << game_by_game_id[0]
    # end


    #-----
    # games_by_season_id.each do |game_by_season_id|
    #   season_ids << game_by_season_id[0]
    # end
    # the next thing that needs to happen is that all of the games for each of those season
    # games_by_game_id.find_all do |game_by_game_id|
    #   game_by_game_id
    #-------

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
