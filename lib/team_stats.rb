require_relative './helper_methods'
class TeamStats
  attr_reader :game_teams,
              :teams,
              :games
  def initialize(filepath1, filepath2, filepath3)
    @game_teams = HelperMethods.load_game_teams(filepath1)
    @games      = HelperMethods.load_games(filepath2)
    @teams      = HelperMethods.load_teams(filepath3)
  end

  def team_info(team_id)
    team_info = {}
    information = @teams.find { |team| team.team_id == team_id }
    team_info["team_id"]= information.team_id
    team_info["franchise_id"]= information.franchise_id
    team_info["team_name"]= information.team_name
    team_info["abbreviation"]= information.abbreviation
    team_info["link"]= information.link
    team_info
  end

  def get_games_by_team_id_array(team_id)
    games_by_team_id_array = []
    @games.each {|game| game.away_team_id == team_id || game.home_team_id == team_id ? games_by_team_id_array << game : next }
    games_by_team_id_array
  end

  def wins_by_season_count
    season_wins = @wins.group_by {|game| game.season}
    season_wins_count = {}
    season_wins.each {|season, season_games| season_wins_count[season] = (season_games.count) }
    season_wins_count
  end

  def find_season_hash(team_id)
    get_games_by_team_id_array(team_id).group_by { |game| game.season }
  end

  def games_by_team_id(team_id)
    games_by_season_count = {}
    find_season_hash(team_id).each { |season, season_games| games_by_season_count[season] = (season_games.count) }
    games_by_season_count
  end

  def wins_by_team_id(team_id)
    @wins = []
    find_season_hash(team_id).each { |season| season[1].each { |game| (team_id == game.away_team_id) && (game.away_goals > game.home_goals) || (team_id == game.home_team_id) && (game.away_goals < game.home_goals) ? @wins << game : next } }
    @wins
  end

  def team_games_by_season(team_id)
    team_games = []
    find_season_hash(team_id).each { |season1| season1[1].each { |game| team_id == game.away_team_id || team_id == game.home_team_id ? team_games << game : next } }
    team_games
  end

  def find_wins(other_team_by_game, team_id)
    wins = []
    other_team_by_game[1].each { |game| (team_id == game.away_team_id) && (game.away_goals < game.home_goals) || (team_id == game.home_team_id) && (game.away_goals > game.home_goals) ? wins << game : next }
    wins
  end

  def find_ties(other_team_by_game, team_id)
    ties = []
    other_team_by_game[1].each { |game| (team_id == game.away_team_id) && (game.away_goals == game.home_goals) || (team_id == game.home_team_id) && (game.away_goals == game.home_goals) ? ties << game : next }
    ties
  end

  def find_other_teams_by_win_percentage(other_teams_by_game, team_id)
    other_teams_by_win_percentage = {}
    other_teams_by_game.each {|other_team_by_game| wins = find_wins(other_team_by_game, team_id) ; ties = find_ties(other_team_by_game, team_id) ; total_wins = (((2 * wins.count.to_f) + ties.count.to_f) / (2 * other_team_by_game[1].count.to_f)).round(2) ; other_teams_by_win_percentage[other_team_by_game[0]] = total_wins }
    other_teams_by_win_percentage
  end

  def find_home_and_away_goals(team_id)
    away_goals = []
    home_goals = []
    @games.each { |game| (team_id == game.away_team_id) ? away_goals << game.away_goals : (team_id == game.home_team_id) ? home_goals << game.home_goals : next }
    away_goals.concat(home_goals)
  end

  def find_home_games_in_games(team_id)
    home_games = []
    @games.find_all { |game| game.home_team_id == team_id ? home_games << game : next }
    home_games
  end

  def find_away_games_in_games(team_id)
    away_games = []
    @games.find_all { |game| game.away_team_id == team_id ? away_games << game : next }
    away_games
  end

  def find_other_teams_by_game(team_id)
    home_games = find_home_games_in_games(team_id)
    away_games = find_away_games_in_games(team_id)
    home_teams_by_game = away_games.group_by { |away_game| away_game.home_team_id }
    away_teams_by_game = home_games.group_by {|home_game| home_game.away_team_id }
    home_teams_by_game.merge(away_teams_by_game)
  end

  def find_season_by_win_percentage(wins_by_season_count, games_by_season_count)
    season_by_win_percentage = {}
    wins_by_season_count.each { |win_by_season_count| games_by_season_count.each { |game_by_season_count| game_by_season_count[0] == win_by_season_count[0] ? season_by_win_percentage[win_by_season_count[0]]= win_by_season_count[1].to_f / game_by_season_count[1].to_f : next } }
    season_by_win_percentage
  end

  def best_season(team_id)
    games_by_season_count = games_by_team_id(team_id)
    wins_by_team_id(team_id).count
    wins_by_season_count
    season_by_win_percentage = find_season_by_win_percentage(wins_by_season_count, games_by_season_count)
    HelperMethods.largest_hash_value(season_by_win_percentage)[0].to_s
  end

  def worst_season(team_id)
    games_by_season_count = games_by_team_id(team_id)
    wins_by_team_id(team_id).count
    wins_by_season_count
    season_by_win_percentage = find_season_by_win_percentage(wins_by_season_count, games_by_season_count)
    HelperMethods.smallest_hash_value(season_by_win_percentage)[0].to_s
  end

  def average_win_percentage(team_id)
    (wins_by_team_id(team_id).count.to_f / team_games_by_season(team_id).count.to_f).round(2)
  end

  def most_goals_scored(team_id)
    find_home_and_away_goals(team_id).max.to_i
  end
  
  def fewest_goals_scored(team_id)
    find_home_and_away_goals(team_id).min.to_i
  end

  def favorite_opponent(team_id)
    other_teams_by_game = find_other_teams_by_game(team_id)
    other_teams_by_win_percentage = find_other_teams_by_win_percentage(other_teams_by_game, team_id)
    favorite_opponent_team_id = HelperMethods.smallest_hash_value(other_teams_by_win_percentage)
    HelperMethods.find_team_name(favorite_opponent_team_id)[0]
  end

  def rival(team_id)
    other_teams_by_game = find_other_teams_by_game(team_id)
    other_teams_by_win_percentage = find_other_teams_by_win_percentage(other_teams_by_game, team_id)
    rival_team_id = HelperMethods.largest_hash_value(other_teams_by_win_percentage)
    HelperMethods.find_team_name(rival_team_id)[0]
  end
end
