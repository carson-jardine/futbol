require 'CSV'
require_relative './game_teams'
require_relative './game'
require_relative './team'

class HelperMethods

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

  def self.games_find_by_game_id(game_id)
    games.find do |season_stat|
      season_stat.game_id == game_id
    end
  end

  def self.teams_find_by_team_id(team_id)
    teams.find do |season_stat|
      season_stat.team_id == team_id
    end
  end

  def self.largest_hash_value(hash)
    hash.max_by{|k,v| v}
  end

  def self.smallest_hash_value(hash)
    hash.min_by{|k,v| v}
  end

  def self.find_win_games(game_teams)
    game_teams.find_all do |game_team|
      game_team.result == "WIN"
    end
  end

  def self.find_lose_games(game_teams)
    game_teams.find_all do |game_team|
      game_team.result == "LOSS"
    end
  end

  def self.find_away_games(game_teams)
    game_teams.find_all do |game_team|
      game_team.hoa == "away"
    end
  end

  def self.find_home_games(game_teams)
    game_teams.find_all do |game_team|
      game_team.hoa == "home"
    end
  end

  def self.find_result_games_with_key_as_game_id(result_games)
    result_games.group_by do |game_won|
      game_won.game_id.to_s
    end
  end

  def self.find_this_season(the_season)
    this_season = []
    @games.find_all do |game_in_season|
      if game_in_season.season == the_season
        this_season << game_in_season
      end
    end
    this_season
  end

  def self.find_result_games_this_season(this_season, result_games_with_key_as_game_id)
    result_games_this_season = []
    this_season.each do |the_game|
      if result_games_with_key_as_game_id.keys.any?(the_game.game_id) == true
        result_games_this_season << the_game
      end
    end
    result_games_this_season
  end

  def self.find_games_by_game_id(games_this_season)
    result_games_by_game_id = []
    games_this_season.group_by do |game_this_season|
      result_games_by_game_id << game_this_season.game_id
    end
    result_games_by_game_id
  end

  def self.find_game_list(games_with_key_as_game_id, games_by_game_id)
    game_list = []
    games_with_key_as_game_id.find_all do |game_result|
      if games_by_game_id.any?(game_result[0]) == true
        game_list << game_result[1]
      end
    end
    game_list.flatten
  end

  def self.find_game_list_with_reduce(games_with_key_as_game_id, games_by_game_id)
    game_list = []
    games_with_key_as_game_id.find_all do |game_result|
      if games_by_game_id.any?(game_result[0]) == true
        game_list << game_result[1].reduce
      end
    end
    game_list
  end

  def self.find_teams_by_team_id(game_teams)
    game_teams.group_by do |game_team|
      game_team.team_id
    end
  end

  def self.find_teams_by_game_id(game_teams)
    game_teams.group_by do |game_team|
      game_team.game_id
    end
  end

  def self.find_team_and_results(teams_by_id, this_season)
    find_team_and_results = {}
    teams_by_id.each do |team|
      find_team_and_results[team[0]] = (team[1].count.to_f * 100) / this_season.count.to_f
    end

    find_team_and_results
  end

  def self.find_team_and_accuracy(teams_by_id)
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

  def self.find_team_and_tackles(teams_by_id)
    team_and_total_tackles = {}
    teams_by_id.each do |team|
      goals_by_team = team[1].sum do |the_tackles|
        the_tackles.tackles
      end
      team_and_total_tackles[team[0]] = goals_by_team
    end
    team_and_total_tackles
  end

  def self.all_the_goals(teams_by_id)
    team_and_total_score = {}
    teams_by_id.each do |team|
      goals_by_team = team[1].sum do |the_goals|
        the_goals.goals
      end
      team_and_total_score[team[0]] = goals_by_team
    end
    team_and_total_score
  end

  def self.find_coach_name(best_or_worst_coach, game_teams)
    coach_name = []
    game_teams.each do |team|
      if team.team_id == best_or_worst_coach
        coach_name << team.head_coach
      end
    end
    coach_name
  end

  # def self.find_team_name(best_or_worst_team)
  #   team_name = []
  #   # binding.pry
  #   @teams.each do |team|
  #     if team.team_id == best_or_worst_team
  #       team_name << team.team_name
  #     end
  #   end
  #   team_name
  # end

  def self.find_team_name(id)
    team = @teams.find_all do |team|
      team.team_id
    end
    team[0].team_name
  end

end
