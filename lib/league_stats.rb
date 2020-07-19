require 'CSV'

require_relative './games'
require_relative './teams'
require_relative './game_teams'

class LeagueStats

  attr_reader :game_teams,
              :teams,
              :games

  def initialize(filepath)
    @game_teams = []
    @teams = []
    @games = []
    load_game_teams(filepath)
    load_teams(filepath)
    load_games(filepath)
  end


  def load_game_teams(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @game_teams << GameTeams.new(data)
    end
  end

  def load_teams(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @teams << Teams.new(data)
    end
  end

  def load_games(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @games << Games.new(data)
    end
  end

  def game_teams_find_by_game_id(game_id)
    @game_teams.find do |season_stat|
      season_stat.game_id == game_id
    end
  end

  def teams_find_by_team_id(team_id)
    @teams.find do |season_stat|
      season_stat.team_id == team_id
    end
  end

  def games_find_by_game_id(game_id)
    @games.find do |season_stat|
      season_stat.game_id == game_id
    end
  end

  # #LEAGUE STATS
  #
  # # 	Total number of teams in the data.  INTEGER
  #   def count_of_teams
  #
  #   end
  #
  # #  Name of the team with the highest average number of goals scored per game across all seasons.  STRING
  #   def best_offense
  #
  #   end
  #
  #  # Name of the team with the lowest average number of goals scored per game across all seasons.  STRING
  #   def worst_offense
  #
  #   end
  #
  # # Name of the team with the highest average score per game across all seasons when they are away.  STRING
  #   def highest_scoring_visitor
  #
  #   end
  #
  # # Name of the team with the highest average score per game across all seasons when they are home.  STRING
  #   def highest_scoring_home_team
  #
  #   end
  #
  #  # Name of the team with the lowest average score per game across all seasons when they are a visitor.  STRING
  #   def lowest_scoring_visitor
  #
  #   end
  #
  #  # 	Name of the team with the lowest average score per game across all seasons when they are at home.  STRING
  #   def lowest_scoring_home_team
  #
  #   end



end
