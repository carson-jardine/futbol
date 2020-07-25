# require_relative './helper_methods'

class SeasonStats < HelperMethods

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
    teams_by_id = find_teams_by_team_id(win_game_list)
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
    teams_by_id = find_teams_by_team_id(lose_game_list)
    team_and_losses = find_team_and_results(teams_by_id, this_season)
    worst_coach = largest_hash_value(team_and_losses)[0]
    coach_name = find_coach_name(worst_coach)
    coach_name[0]
  end

  def most_accurate_team(the_season)
    game_teams_by_id = find_teams_by_game_id(game_teams)
    this_season = find_this_season(the_season)
    this_season_game_ids = find_games_by_game_id(this_season)
    game_list = find_game_list(game_teams_by_id, this_season_game_ids)
    flattened_game_list = game_list.flatten
    teams_by_id = find_teams_by_team_id(flattened_game_list)
    team_and_accuracy = find_team_and_accuracy(teams_by_id)
    best_team = largest_hash_value(team_and_accuracy)[0]
    team_name = find_team_name(best_team)
    team_name[0]
  end

  def least_accurate_team(the_season)
    game_teams_by_id = find_teams_by_game_id(game_teams)
    this_season = find_this_season(the_season)
    this_season_game_ids = find_games_by_game_id(this_season)
    game_list = find_game_list(game_teams_by_id, this_season_game_ids)
    flattened_game_list = game_list.flatten
    teams_by_id = find_teams_by_team_id(flattened_game_list)
    team_and_accuracy = find_team_and_accuracy(teams_by_id)
    worst_team = smallest_hash_value(team_and_accuracy)[0]
    team_name = find_team_name(worst_team)
    team_name[0]
  end

  def most_tackles(the_season)
    this_season = find_this_season(the_season)
    game_teams_by_id = find_teams_by_game_id(game_teams)
    this_season_game_ids = find_games_by_game_id(this_season)
    game_list = find_game_list(game_teams_by_id, this_season_game_ids)
    flattened_game_list = game_list.flatten
    teams_by_id = find_teams_by_team_id(flattened_game_list)
    team_and_total_tackles = find_team_and_tackles(teams_by_id)
    top_tacklers = largest_hash_value(team_and_total_tackles)[0]
    highest_tacklers = find_team_name(top_tacklers)
    highest_tacklers[0]
  end

  def fewest_tackles(the_season)
    this_season = find_this_season(the_season)
    game_teams_by_id = find_teams_by_game_id(game_teams)
    this_season_game_ids = find_games_by_game_id(this_season)
    game_list = find_game_list(game_teams_by_id, this_season_game_ids)
    flattened_game_list = game_list.flatten
    teams_by_id = find_teams_by_team_id(flattened_game_list)
    team_and_total_tackles = find_team_and_tackles(teams_by_id)
    bottom_tacklers = smallest_hash_value(team_and_total_tackles)[0]
    lowest_tacklers = find_team_name(bottom_tacklers)
    lowest_tacklers[0]
  end

end
