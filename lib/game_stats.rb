# require 'CSV'
# require_ './lib/game'

class GameStats < Game
  attr_reader :games
  def initialize(filepath)
    @games = []
    load_games(filepath)
  end

  def load_games(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @games << Game.new(data)
    end
  end

  def find_by_id(game_id)
    @games.find do |game|
      game.game_id == game_id
    end
  end

  def highest_total_score
    highest_score = @games.max_by do |game|
      (game.home_goals.to_i) + (game.away_goals.to_i)
    end
    highest_score.home_goals.to_i + highest_score.away_goals.to_i
  end

  def lowest_total_score
    lowest_score = @games.min_by do |game|
      (game.home_goals.to_i) + (game.away_goals.to_i)
    end
    lowest_score.home_goals.to_i + lowest_score.away_goals.to_i
  end

  def percentage_home_wins
    home_games = @games.group_by do |game|
      game.home_team_id
    end
    home_games_wins = home_games.map do |game_id, games|
      # games.map(&:home_goals) > games.map(&:away_goals)
      games.find_all do |game|
        game.home_goals > game.away_goals
      end
    end
    (home_games_wins.flatten.length / @games.count.to_f).round(2)
    # ((home_games_wins.count.to_f / home_games.count.to_f) * 100).round(2)
  end


  def percentage_visitor_wins
    away_games = @games.group_by do |game|
      game.away_team_id
    end
    away_games_wins = away_games.map do |game_id, games|
      games.find_all do |game|
        game.away_goals > game.home_goals
      end
    end
    (away_games_wins.flatten.length / @games.count.to_f).round(2)
  end

  def percentage_ties
    tied_games = @games.find_all do |game|
      game.home_goals == game.away_goals
    end
    (tied_games.count.to_f / @games.count.to_f).round(2)
  end

    def count_of_games_by_season
     games_by_season = {} #
     season_by_id = games.group_by do |game|
       game.season
     end
     season_by_id.each do |season|
      games_by_season[season[0]] = season[1].count
     end
     games_by_season
    end

    def average_goals_per_game
      result = games.map do |game|
        game.total_goals_for_game
      end
      (result.sum.to_f / result.count.to_f).round(2)
    end

    def average_goals_for_season(season_games)
      goal_totals = []
      season_games.each do |game|
        goal_totals << game.total_goals_for_game
      end
      (goal_totals.sum.to_f / goal_totals.count.to_f).round(2)
    end

    def average_goals_by_season
     avg_goals_per_season = {}
     season_by_id = games.group_by do |game|
       game.season
     end
     season_by_id.each do |season, season_games|
       avg_goals_per_season[season] = average_goals_for_season(season_games)
     end
     avg_goals_per_season
    end

end
