def most_goals_scored(team_id)
  games_by_team_id(team_id)
  games_by_season
  @away_goals = []
  @home_goals = []
  @seasons_hash.each do |season|
    season[1].each do |game|
      if (team_id == game.away_team_id)
        @away_goals << game.away_goals
      elsif (team_id == game.home_team_id)
        @home_goals << game.home_goals
      end
    end
  end
  @away_goals.concat(@home_goals).max
end

def fewest_goals_scored(team_id)
  games_by_team_id(team_id)
  games_by_season
  @away_goals = []
  @home_goals = []
  @seasons_hash.each do |season|
    season[1].each do |game|
      if (team_id == game.away_team_id)
        @away_goals << game.away_goals
      elsif (team_id == game.home_team_id)
        @home_goals << game.home_goals
      end
    end
  end
  @away_goals.concat(@home_goals).min
end
