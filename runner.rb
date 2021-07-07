require './lib/stat_tracker'
require 'pry'
game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
<<<<<<< HEAD
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

require 'pry'; binding.pry
=======
  game_teams: game_teams_path,
  teams: team_path
}

stat_tracker = StatTracker.from_csv(locations)
<<<<<<< HEAD
require 'pry'; binding.pry
=======
<<<<<<< HEAD
binding.pry
=======
require 'pry'; binding.pry
>>>>>>> 4645662efbd4ee50ec7423fe504d35c178f1ef6b
>>>>>>> 93f7d732e57b22b92d0bd3126e6cdd10c8d1e2fb
