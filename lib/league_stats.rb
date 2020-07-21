require 'CSV'
require_relative './game_teams'
require_relative './game'
require_relative './team'

class LeagueStats

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


  # #LEAGUE STATS METHODS
  #
  # # 	Total number of teams in the data.  INTEGER
    def count_of_teams
      teams.count
    end
  #
  # #  Name of the team with the highest average number of goals scored per game across all seasons.  STRING
    def best_offense
      team_and_total_score = {}
      best_team = []
      #first, group/arrange the games according to their team_id in a hash.
      # Key = team_id, value = stats for the games that team was in
      teams_by_id = game_teams.group_by do |game_team|
        game_team.team_id
      end
      #next, make a new hash of key = team_id, value = total # of goals across all games.
      teams_by_id.each do |team|
        goals_by_team = team[1].sum do |the_goals|
          the_goals.goals
        end
        team_and_total_score[team[0]] = goals_by_team
      end
      #next find the key that has the highest value, and assign that key to @top_scorer
      top_scorer = largest_hash_key(team_and_total_score)[0]
      #next, find the team name that correlates to the @top_scorer
      teams.each do |team|
        if team.team_id == top_scorer
          best_team << team.teamname
        end
      end
      #finally, print the teamname.
      best_team[0]
    end

  #
  #  # Name of the team with the lowest average number of goals scored per game across all seasons.  STRING
    def worst_offense
      team_and_total_score = {}
      worst_team = []
      teams_by_id = game_teams.group_by do |game_team|
        game_team.team_id
      end
      teams_by_id.each do |team|
        goals_by_team = team[1].sum do |the_goals|
          the_goals.goals
        end
        team_and_total_score[team[0]] = goals_by_team
      end
      bottom_scorer = smallest_hash_key(team_and_total_score)[0]
      teams.each do |team|
        if team.team_id == bottom_scorer
          worst_team << team.teamname
        end
      end
      worst_team[0]
    end
  #
  # # Name of the team with the highest average score per game across all seasons when they are away.  STRING
    def highest_scoring_visitor
      team_and_total_score = {}
      best_team = []
      away_games = game_teams.find_all do |game_team|
        game_team.hoa == "away"
      end
      teams_by_id = away_games.group_by do |away_game|
        away_game.team_id
      end
      teams_by_id.each do |team|
        goals_by_team = team[1].sum do |the_goals|
          the_goals.goals
        end
        team_and_total_score[team[0]] = goals_by_team
      end
      top_scorer = largest_hash_key(team_and_total_score)[0]
      teams.each do |team|
        if team.team_id == top_scorer
          best_team << team.teamname
        end
      end
      best_team[0]
    end
  #
  # # Name of the team with the highest average score per game across all seasons when they are home.  STRING
    def highest_scoring_home_team
      team_and_total_score = {}
      best_team = []
      home_games = game_teams.find_all do |game_team|
        game_team.hoa == "home"
      end
      teams_by_id = home_games.group_by do |home_game|
        home_game.team_id
      end
      teams_by_id.each do |team|
        goals_by_team = team[1].sum do |the_goals|
          the_goals.goals
        end
        team_and_total_score[team[0]] = goals_by_team
      end
      top_scorer = largest_hash_key(team_and_total_score)[0]
      teams.each do |team|
        if team.team_id == top_scorer
          best_team << team.teamname
        end
      end
      best_team[0]
    end
  #
  #  # Name of the team with the lowest average score per game across all seasons when they are a visitor.  STRING
    def lowest_scoring_visitor
      team_and_total_score = {}
      worst_team = []
      away_games = game_teams.find_all do |game_team|
        game_team.hoa == "away"
      end
      teams_by_id = away_games.group_by do |away_game|
        away_game.team_id
      end
      teams_by_id.each do |team|
        goals_by_team = team[1].sum do |the_goals|
          the_goals.goals
        end
        team_and_total_score[team[0]] = goals_by_team
      end
      bottom_scorer = smallest_hash_key(team_and_total_score)[0]
      teams.each do |team|
        if team.team_id == bottom_scorer
          worst_team << team.teamname
        end
      end
      worst_team[0]
    end
  #
  #  # 	Name of the team with the lowest average score per game across all seasons when they are at home.  STRING
    def lowest_scoring_home_team
      team_and_total_score = {}
      worst_team = []
      away_games = game_teams.find_all do |game_team|
        game_team.hoa == "home"
      end
      teams_by_id = away_games.group_by do |away_game|
        away_game.team_id
      end
      teams_by_id.each do |team|
        goals_by_team = team[1].sum do |the_goals|
          the_goals.goals
        end
        team_and_total_score[team[0]] = goals_by_team
      end
      bottom_scorer = smallest_hash_key(team_and_total_score)[0]
      teams.each do |team|
        if team.team_id == bottom_scorer
          worst_team << team.teamname
        end
      end
      worst_team[0]
    end


end
