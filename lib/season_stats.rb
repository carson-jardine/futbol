<<<<<<< HEAD
require './helper_methods'
=======
# require './helper_methods'
>>>>>>> 41a8dac3daee847781f139d57e6f499f26a1463d

class SeasonStats

  attr_reader :game_teams,
              :teams,
              :games

  def initialize(filepath1 = nil, filepath2 = nil, filepath3 = nil)

    @game_teams = HelperMethods.load_game_teams(filepath1)
    @games      = HelperMethods.load_games(filepath2)
    @teams      = HelperMethods.load_teams(filepath3)
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


  def winningest_coach(the_season)
    HelperMethods.find_head_coach_best_worst(@games, @game_teams, the_season, "WIN").max_by {|x| x[1]}[0]
  end

  def worst_coach(the_season)
    HelperMethods.find_head_coach_best_worst(@games, @game_teams, the_season, "WIN").min_by {|x| x[1]}[0]
  end

  def most_accurate_team(the_season)
    game_teams_by_id = HelperMethods.find_teams_by_game_id(game_teams)
    this_season = HelperMethods.find_this_season(the_season)
    this_season_game_ids = HelperMethods.find_games_by_game_id(this_season)
    game_list = HelperMethods.find_game_list(game_teams_by_id, this_season_game_ids)
    flattened_game_list = game_list.flatten
    teams_by_id = HelperMethods.find_teams_by_team_id(flattened_game_list)
    team_and_accuracy = HelperMethods.find_team_and_accuracy(teams_by_id)
    best_team = HelperMethods.largest_hash_value(team_and_accuracy)
    team_name = HelperMethods.find_team_name_for_accuracy(best_team)

    team_name
    binding.pry
  end

  def least_accurate_team(the_season)
    game_teams_by_id = HelperMethods.find_teams_by_game_id(game_teams)
    this_season = HelperMethods.find_this_season(the_season)
    this_season_game_ids = HelperMethods.find_games_by_game_id(this_season)
    game_list = HelperMethods.find_game_list(game_teams_by_id, this_season_game_ids)
    flattened_game_list = game_list.flatten
    teams_by_id = HelperMethods.find_teams_by_team_id(flattened_game_list)
    team_and_accuracy = HelperMethods.find_team_and_accuracy(teams_by_id)
    worst_team = HelperMethods.smallest_hash_value(team_and_accuracy)
    team_name = HelperMethods.find_team_name_for_accuracy(worst_team)
    team_name
  end

  def most_tackles(the_season)
    this_season = HelperMethods.find_this_season(the_season)
    game_teams_by_id = HelperMethods.find_teams_by_game_id(game_teams)
    this_season_game_ids = HelperMethods.find_games_by_game_id(this_season)
    game_list = HelperMethods.find_game_list(game_teams_by_id, this_season_game_ids)
    flattened_game_list = game_list.flatten
    teams_by_id = HelperMethods.find_teams_by_team_id(flattened_game_list)
    team_and_total_tackles = HelperMethods.find_team_and_tackles(teams_by_id)
    top_tacklers = HelperMethods.largest_hash_value(team_and_total_tackles)
    highest_tacklers = HelperMethods.find_team_name(top_tacklers)
    highest_tacklers
  end

  def fewest_tackles(the_season)
    this_season = HelperMethods.find_this_season(the_season)
    game_teams_by_id = HelperMethods.find_teams_by_game_id(game_teams)
    this_season_game_ids = HelperMethods.find_games_by_game_id(this_season)
    game_list = HelperMethods.find_game_list(game_teams_by_id, this_season_game_ids)
    flattened_game_list = game_list.flatten
    teams_by_id = HelperMethods.find_teams_by_team_id(flattened_game_list)
    team_and_total_tackles = HelperMethods.find_team_and_tackles(teams_by_id)
    bottom_tacklers = HelperMethods.smallest_hash_value(team_and_total_tackles)
    lowest_tacklers = HelperMethods.find_team_name(bottom_tacklers)
    lowest_tacklers
  end
end
