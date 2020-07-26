# require './helper_methods'

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
  def winningest_coach(season)
    HelperMethods.find_head_coach_best_worst(@games, @game_teams, the_season, "WIN")
  end

  def worst_coach(the_season)
    HelperMethods.find_head_coach_best_worst(@games, @game_teams, the_season, "LOSS")
  end

  def most_accurate_team(season)
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
