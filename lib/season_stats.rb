require 'CSV'
require_relative './game_teams'
require_relative './game'
require_relative './team'

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

  def largest_hash_key(hash)
    hash.max_by{|k,v| v}
  end

  def smallest_hash_key(hash)
    hash.min_by{|k,v| v}
  end

  def winningest_coach
    teams_by_id = []
    team_and_wins = {}
    best_coach = []
    coach_name = []
    win_games = game_teams.find_all do |game_team|
      game_team.result == "WIN"
    end
    teams_by_id = win_games.group_by do |win_game|
      win_game.team_id
    end
    teams_by_id.each do |team|
      wins_by_team = team[1].count
      team_and_wins[team[0]] = wins_by_team
    end
    best_coach = largest_hash_key(team_and_wins)[0]
    game_teams.each do |team|
      if team.team_id == best_coach
        coach_name << team.head_coach
      end
    end
    coach_name[0]
  end

  def worst_coach
    teams_by_id = []
    team_and_loses = {}
    worst_coach = []
    coach_name = []
    lose_games = game_teams.find_all do |game_team|
      game_team.result == "LOSS"
    end
    teams_by_id = lose_games.group_by do |lose_game|
      lose_game.team_id
    end
    teams_by_id.each do |team|
      loses_by_team = team[1].count
      team_and_loses[team[0]] = loses_by_team
    end
    worst_coach = largest_hash_key(team_and_loses)[0]
    game_teams.each do |team|
      if team.team_id == worst_coach
        coach_name << team.head_coach
      end
    end
    coach_name[0]
  end

  def most_accurate_team
    teams_by_id = []
    team_and_accuracy = {}
    best_team = []
    team_name = []
    team_accuracy = []
    teams_by_id = game_teams.group_by do |game_team|
      game_team.team_id
    end
    teams_by_id.each do |team|
      goals_by_team = team[1].sum do |the_goals|
        the_goals.goals.to_f
      end
      shots_by_team = team[1].sum do |the_shots|
        the_shots.shots.to_f
      end
      team_accuracy = goals_by_team / shots_by_team
      team_and_accuracy[team[0]] = team_accuracy
    end
    best_team = largest_hash_key(team_and_accuracy)[0]
    teams.each do |team|
      if team.team_id == best_team
        team_name << team.teamname
      end
    end
    team_name[0]
  end

  def least_accurate_team
    teams_by_id = []
    team_and_accuracy = {}
    best_team = []
    team_name = []
    team_accuracy = []
    teams_by_id = game_teams.group_by do |game_team|
      game_team.team_id
    end
    teams_by_id.each do |team|
      goals_by_team = team[1].sum do |the_goals|
        the_goals.goals.to_f
      end
      shots_by_team = team[1].sum do |the_shots|
        the_shots.shots.to_f
      end
      team_accuracy = goals_by_team / shots_by_team
      team_and_accuracy[team[0]] = team_accuracy
    end
    best_team = smallest_hash_key(team_and_accuracy)[0]
    teams.each do |team|
      if team.team_id == best_team
        team_name << team.teamname
      end
    end
    team_name[0]
  end

  def most_tackles
    teams_by_id = []
    team_and_total_tackles = {}
    bottom_tacklers = []
    lowest_tacklers = []
    teams_by_id = game_teams.group_by do |game_team|
      game_team.team_id
    end
    teams_by_id.each do |team|
      goals_by_team = team[1].sum do |the_tackles|
        the_tackles.tackles
      end
      team_and_total_tackles[team[0]] = goals_by_team
    end
    bottom_tacklers = largest_hash_key(team_and_total_tackles)[0]
    teams.each do |team|
      if team.team_id == bottom_tacklers
        lowest_tacklers << team.teamname
      end
    end
    lowest_tacklers[0]
  end

  def fewest_tackles
    teams_by_id = []
    team_and_total_tackles = {}
    bottom_tacklers = []
    lowest_tacklers = []
    teams_by_id = game_teams.group_by do |game_team|
      game_team.team_id
    end
    teams_by_id.each do |team|
      goals_by_team = team[1].sum do |the_tackles|
        the_tackles.tackles
      end
      team_and_total_tackles[team[0]] = goals_by_team
    end
    bottom_tacklers = smallest_hash_key(team_and_total_tackles)[0]
    teams.each do |team|
      if team.team_id == bottom_tacklers
        lowest_tacklers << team.teamname
      end
    end
    lowest_tacklers[0]
  end

end
