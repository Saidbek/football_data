module FootballRuby
  module Configuration
    API_ENDPOINT = 'http://api.football-data.org/v1'
    LIVE_ENDPOINT = 'http://soccer-cli.appspot.com'

    attr_accessor :api_token

    def configure
      yield self
    end
  end
end
