require 'json'

module FootballRuby
  class Client < Base
    
    # List all available leagues.
    def leagues(opts={})
      season = opts.fetch(:season) { Time.now.year }

      json_response get("competitions/?season=#{season}")
    end

    # List all teams for a certain league.
    def league_teams(id)
      raise 'missing id' if id.nil?

      json_response get("competitions/#{id}/teams")
    end

    # Show League Table / current standing.
    # Filters:
    #
    # match_day=/\d+/

    def league_table(id, opts={})
      raise 'missing id' if id.nil?

      match_day = opts[:match_day]

      uri = "competitions/#{id}/leagueTable/"
      url = match_day.nil? ? uri : "#{uri}?matchday=#{match_day}"

      json_response get(url)
    end

    # List all fixtures for a certain league.
    # Filters:
    #
    # time_frame=/p|n[1-9]{1,2}/
    # match_day=/\d+/

    def league_fixtures(id, opts={})
      raise 'missing id' if id.nil?

      time_frame  = opts[:time_frame]
      match_day   = opts[:match_day]

      uri = "competitions/#{id}/fixtures/"
      url = time_frame.nil? ? uri : "#{uri}?timeFrame=#{time_frame}"
      url = match_day.nil? ? url : "#{url}?matchday=#{match_day}"

      json_response get(url)
    end

    # List fixtures across a set of leagues.
    # Filters:
    #
    # time_frame=/p|n[1-9]{1,2}/
    # league=leagueCode

    def fixtures(opts={})
      time_frame = opts[:time_frame]
      league = opts[:league]

      uri = "fixtures/"
      url = time_frame.nil? ? uri : "#{uri}?timeFrame=#{time_frame}"
      url = league.nil? ? url : "#{url}?league=#{league}"

      json_response get(url)
    end

    # Show one fixture.
    # Filters:
    #
    # head2head=/\d+/

    def fixture(id, opts={})
      raise 'missing id' if id.nil?

      head2head = opts[:head2head]

      uri = "fixtures/#{id}/"
      url = head2head.nil? ? uri : "#{uri}?head2head=#{head2head}"

      json_response get(url)
    end

    # Show all fixtures for a certain team.
    # Filters:
    #
    # season=/\d\d\d\d/
    # time_frame=/p|n[1-9]{1,2}/
    # venue=/home|away/

    def team_fixtures(id, opts={})
      raise 'missing id' if id.nil?

      season      = opts[:season]
      time_frame  = opts[:time_frame]
      venue       = opts[:venue]

      uri = "teams/#{id}/fixtures/"
      url = season.nil? ? uri : "#{uri}?season=#{season}"
      url = time_frame.nil? ? url : "#{url}?timeFrame=#{time_frame}"
      url = venue.nil? ? url : "#{url}?venue=#{venue}"

      json_response get(url)
    end

    # Show one team.
    def team(id)
      raise 'missing id' if id.nil?

      json_response get("teams/#{id}/")
    end

    # Show all players for a certain team.
    def team_players(id)
      raise 'missing team id' if id.nil?

      json_response get("teams/#{id}/players/")
    end

    # Show live scores
    def live_scores
      json_response get_live_scores
    end

    private

    def json_response(request)
      JSON.parse(request.body, symbolize_names: true)
    end
  end
end
