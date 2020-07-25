require_relative './helper_methods'

class LeagueStats

  attr_reader :game_teams,
              :teams,
              :games

  def initialize(filepath1 = nil, filepath2 = nil, filepath3 = nil)

    @game_teams = HelperMethods.load_game_teams(filepath1)
    @games      = HelperMethods.load_games(filepath2)
    @teams      = HelperMethods.load_teams(filepath3)
  end

  # def load_game_teams(filepath1)
  #   CSV.foreach(filepath1, headers: true, header_converters: :symbol) do |data|
  #     @game_teams << GameTeams.new(data)
  #   end
  # end
  #
  # def load_games(filepath2)
  #   CSV.foreach(filepath2, headers: true, header_converters: :symbol) do |data|
  #     @games << Game.new(data)
  #   end
  # end
  #
  # def load_teams(filepath3)
  #   CSV.foreach(filepath3, headers: true, header_converters: :symbol) do |data|
  #     @teams << Team.new(data)
  #   end
  # end

    def best_offense
      #first, group/arrange the games according to their team_id in a hash.
      # Key = team_id, value = stats for the games that team was in
      teams_by_id = HelperMethods.find_teams_by_team_id(game_teams)
      #next, make a new hash of key = team_id, value = total # of goals across all games.
      team_and_total_score = HelperMethods.all_the_goals(teams_by_id)
      #next find the key that has the highest value, and assign that key to @top_scorer
      top_scorer = HelperMethods.largest_hash_value(team_and_total_score)[0]
      #next, find the team name that correlates to the @top_scorer
      best_team = HelperMethods.find_team_name(top_scorer, @teams)
      #finally, print the teamname.
      best_team[0]
    end

    def worst_offense
      teams_by_id = find_teams_by_team_id(game_teams)
      team_and_total_score = all_the_goals(teams_by_id)
      bottom_scorer = smallest_hash_value(team_and_total_score)[0]
      worst_team = find_team_name(bottom_scorer)
      worst_team[0]
    end

    def highest_scoring_visitor
      away_games = find_away_games(game_teams)
      teams_by_id = find_teams_by_team_id(away_games)
      team_and_total_score = all_the_goals(teams_by_id)
      top_scorer = largest_hash_value(team_and_total_score)[0]
      best_team = find_team_name(top_scorer)
      best_team[0]
    end

    def highest_scoring_home_team
      home_games = find_home_games(game_teams)
      teams_by_id = find_teams_by_team_id(home_games)
      team_and_total_score = all_the_goals(teams_by_id)
      top_scorer = largest_hash_value(team_and_total_score)[0]
      best_team = find_team_name(top_scorer)
      best_team[0]
    end

    def lowest_scoring_visitor
      away_games = find_away_games(game_teams)
      teams_by_id = find_teams_by_team_id(away_games)
      team_and_total_score = all_the_goals(teams_by_id)
      bottom_scorer = smallest_hash_value(team_and_total_score)[0]
      worst_team = find_team_name(bottom_scorer)
      worst_team[0]
    end

    def lowest_scoring_home_team
      home_games = find_home_games(game_teams)
      teams_by_id = find_teams_by_team_id(home_games)
      team_and_total_score = all_the_goals(teams_by_id)
      bottom_scorer = smallest_hash_value(team_and_total_score)[0]
      worst_team = find_team_name(bottom_scorer)
      worst_team[0]
    end
end
