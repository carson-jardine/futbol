require 'CSV'
require_relative './game_teams'
require_relative './game'
require_relative './team'

require 'pry'

class SeasonStats

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

  def game_teams_find_by_game_id(game_id)
    @game_teams.find do |season_stat|
      season_stat.game_id == game_id
    end
  end

  def games_find_by_game_id(game_id)
    @games.find do |season_stat|
      season_stat.game_id == game_id
    end
  end

  def teams_find_by_team_id(team_id)
    @teams.find do |season_stat|
      season_stat.team_id == team_id
    end
  end

  def largest_hash_value(hash)
    hash.max_by{|k,v| v}
  end

  def smallest_hash_value(hash)
    hash.min_by{|k,v| v}
  end

  def find_win_games(game_teams)
    game_teams.find_all do |game_team|
      game_team.result == "WIN"
    end
  end

  def find_lose_games(game_teams)
    game_teams.find_all do |game_team|
      game_team.result == "LOSS"
    end
  end

  def find_result_games_with_key_as_game_id(result_games)
    result_games.group_by do |game_won|
      game_won.game_id
    end
  end

  def find_this_season(the_season)
    this_season = []
    games.find_all do |game_in_season|
      if game_in_season.season == the_season
        this_season << game_in_season
      end
    end
    this_season
  end

  def find_result_games_this_season(this_season, result_games_with_key_as_game_id)
    result_games_this_season = []
    this_season.each do |the_game|
      if result_games_with_key_as_game_id.keys.any?(the_game.game_id) == true
        result_games_this_season << the_game
      end
    end
    result_games_this_season
  end

  def find_games_by_game_id(games_this_season)
    result_games_by_game_id = []
    games_this_season.group_by do |game_this_season|
      result_games_by_game_id << game_this_season.game_id
    end
    result_games_by_game_id
  end

  def find_game_list(games_with_key_as_game_id, games_by_game_id)
    game_list = []
    games_with_key_as_game_id.find_all do |game_result|
      if games_by_game_id.any?(game_result[0]) == true
        game_list << game_result[1]
      end
    end
    game_list
  end

  def find_game_list_with_reduce(games_with_key_as_game_id, games_by_game_id)
    game_list = []
    games_with_key_as_game_id.find_all do |game_result|
      if games_by_game_id.any?(game_result[0]) == true
        game_list << game_result[1].reduce
      end
    end
    game_list
  end

  def get_teams_by_team_id(game_teams)
    game_teams.group_by do |game_team|
      game_team.team_id
    end
  end

  def get_teams_by_game_id(game_teams)
    game_teams.group_by do |game_team|
      game_team.game_id
    end
  end

  def find_team_and_results(teams_by_id, this_season)
    find_team_and_results = {}
    teams_by_id.each do |team|
      find_team_and_results[team[0]] = team[1].count.to_f / this_season.count.to_f
    end
    find_team_and_results
  end

  def find_team_and_accuracy(teams_by_id)
    team_and_accuracy = {}
    teams_by_id.each do |team|
      goals_by_team = team[1].sum do |the_goals|
        the_goals.goals.to_f
      end
      shots_by_team = team[1].sum do |the_shots|
        the_shots.shots.to_f
      end
      team_and_accuracy[team[0]] = goals_by_team / shots_by_team
    end
    team_and_accuracy
  end

  def find_coach_name(best_or_worst_coach)
    coach_name = []
    game_teams.each do |team|
      if team.team_id == best_or_worst_coach
        coach_name << team.head_coach
      end
    end
    coach_name
  end

  def find_team_name(best_or_worst_team)
    team_name = []
    teams.each do |team|
      if team.team_id == best_or_worst_team
        team_name << team.teamname
      end
    end
    team_name
  end


# Name of the Coach with the best win percentage for the season
  def winningest_coach(the_season)
    # first you get all the games in the game_teams that were Wins
    win_games = find_win_games(game_teams)
    #then you group them into a hash with key = game_id and value = all the info about the games that were WINs
    win_games_with_key_as_game_id = find_result_games_with_key_as_game_id(win_games)
    # We're done with that data for a second, but we'll come back to win_games_with_key_as_game_id later.
    # For now you need to get all the games in the season that's been prompted by the arguement.  This here makes an array of those games called this_season:
    this_season = find_this_season(the_season)
    # However, that game information doesn't have the "WIN" information.
    # So you have to see if the game_id in this new this_season match the games in which there was a win, and make a new thing, win_games_this_season, to hold that list of game_id's that match.  Basically this is testing to see if the WIN games are in the season we're looking at.  the new array has all the gameinfo of all the games that were winners and in our season.
    win_games_this_season = find_result_games_this_season(this_season, win_games_with_key_as_game_id)

    # now make a hash of key = game_id value = game info of games where there was a win
    win_games_by_game_id = find_games_by_game_id(win_games_this_season)
    # this is where it translates the game_id's of the games that were in our season and winners into an array of game_teams information so that we can then look at the win percentage.
    win_game_list = find_game_list_with_reduce(win_games_with_key_as_game_id, win_games_by_game_id)
    # This breaks down the games into a hash with key = team_id and value = games that team played this season.
    teams_by_id = get_teams_by_team_id(win_game_list)
    # This one is creating a hash called team_and_wins where the key is the team_id and the value is the percentage of wins per games in that season.
    team_and_wins = find_team_and_results(teams_by_id, this_season)
    #this finds the team_id that has the highest percentage
    best_coach = largest_hash_value(team_and_wins)[0]
    #and this takes that team_id and finds the corresponding coach_name
    coach_name = find_coach_name(best_coach)
    coach_name[0]
  end

  def worst_coach(the_season)
    lose_games = find_lose_games(game_teams)
    lose_games_with_key_as_game_id = find_result_games_with_key_as_game_id(lose_games)
    this_season = find_this_season(the_season)
    lose_games_this_season = find_result_games_this_season(this_season, lose_games_with_key_as_game_id)
    lose_games_by_game_id = find_games_by_game_id(lose_games_this_season)
    lose_game_list = find_game_list_with_reduce(lose_games_with_key_as_game_id, lose_games_by_game_id)
    teams_by_id = get_teams_by_team_id(lose_game_list)
    team_and_losses = find_team_and_results(teams_by_id, this_season)
    worst_coach = largest_hash_value(team_and_losses)[0]
    coach_name = find_coach_name(worst_coach)
    coach_name[0]
  end

  def most_accurate_team(the_season)
    game_teams_by_id = get_teams_by_game_id(game_teams)
    this_season = find_this_season(the_season)
    this_season_game_ids = find_games_by_game_id(this_season)
    game_list = find_game_list(game_teams_by_id, this_season_game_ids)
    flattened_game_list = game_list.flatten
    teams_by_id = get_teams_by_team_id(flattened_game_list)
    team_and_accuracy = find_team_and_accuracy(teams_by_id)
    best_team = largest_hash_value(team_and_accuracy)[0]
    team_name = find_team_name(best_team)
    team_name[0]
  end
  #
  def least_accurate_team(the_season)
    game_teams_by_id = get_teams_by_game_id(game_teams)
    this_season = find_this_season(the_season)
    this_season_game_ids = find_games_by_game_id(this_season)
    game_list = find_game_list(game_teams_by_id, this_season_game_ids)
    flattened_game_list = game_list.flatten
    teams_by_id = get_teams_by_team_id(flattened_game_list)
    team_and_accuracy = find_team_and_accuracy(teams_by_id)
    worst_team = smallest_hash_value(team_and_accuracy)[0]
    team_name = find_team_name(worst_team)
    team_name[0]
  end

  def most_tackles(the_season)
    team_and_total_tackles = {}
    highest_tacklers = []
    this_season = []
    this_season_game_ids = []
    game_list = []
    games.find_all do |game_in_season|
      if game_in_season.season == the_season
        this_season << game_in_season
      end
    end
    game_teams_by_id = game_teams.group_by do |game_team|
      game_team.game_id
    end
    this_season.group_by do |this_one_season|
      this_season_game_ids << this_one_season.game_id
    end
    game_teams_by_id.find_all do |game_team_by_id|
      if this_season_game_ids.any?(game_team_by_id[0]) == true
        game_list << game_team_by_id[1]
      end
    end
    flattened_game_list = game_list.flatten
    teams_by_id = flattened_game_list.group_by do |game_team|
      game_team.team_id
    end
    teams_by_id.each do |team|
      goals_by_team = team[1].sum do |the_tackles|
        the_tackles.tackles
      end
      team_and_total_tackles[team[0]] = goals_by_team
    end
    top_tacklers = largest_hash_value(team_and_total_tackles)[0]
    teams.each do |team|
      if team.team_id == top_tacklers
        highest_tacklers << team.teamname
      end
    end
    highest_tacklers[0]
  end
  #
  def fewest_tackles(the_season)
    team_and_total_tackles = {}
    lowest_tacklers = []
    this_season = []
    this_season_game_ids = []
    game_list = []
    games.find_all do |game_in_season|
      if game_in_season.season == the_season
        this_season << game_in_season
      end
    end
    game_teams_by_id = game_teams.group_by do |game_team|
      game_team.game_id
    end
    this_season.group_by do |this_one_season|
      this_season_game_ids << this_one_season.game_id
    end
    game_teams_by_id.find_all do |game_team_by_id|
      if this_season_game_ids.any?(game_team_by_id[0]) == true
        game_list << game_team_by_id[1]
      end
    end
    flattened_game_list = game_list.flatten
    teams_by_id = flattened_game_list.group_by do |game_team|
      game_team.team_id
    end
    teams_by_id.each do |team|
      goals_by_team = team[1].sum do |the_tackles|
        the_tackles.tackles
      end
      team_and_total_tackles[team[0]] = goals_by_team
    end
    bottom_tacklers = smallest_hash_value(team_and_total_tackles)[0]
    teams.each do |team|
      if team.team_id == bottom_tacklers
        lowest_tacklers << team.teamname
      end
    end
    lowest_tacklers[0]
  end

end
