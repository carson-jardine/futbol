class Team

  attr_reader :team_id,
              :franchiseid,
              :teamname,
              :abbreviation,
              :stadium,
              :link

  def initialize(teams_info)
    @team_id      = teams_info[:team_id].to_i
    @franchiseid  = teams_info[:franchiseid].to_i
    @teamname     = teams_info[:teamname].to_s
    @abbreviation = teams_info[:abbreviation]
    @stadium      = teams_info[:stadium]
    @link         = teams_info[:link]
  end

end
