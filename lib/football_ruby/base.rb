module FootballRuby
  class Base
    def get(path, params={})
      uri = URI("#{FootballRuby::Configuration::API_ENDPOINT}/#{path}")
      request = build_request(uri, build_headers(params))

      build_response(uri, request)
    end

    def get_live_scores
      uri = URI("#{FootballRuby::Configuration::LIVE_ENDPOINT}/")
      request = build_request(uri)

      build_response(uri, request)
    end

    private

    def build_headers(params)
      raise ApiTokenMissingError, 'Please set up your api token' if FootballRuby.api_token.nil?

      {
        'X-Auth-Token': FootballRuby.api_token
      }.merge(params)
    end

    def build_request(uri, headers={})
      Net::HTTP::Get.new(uri, headers)
    end

    def build_response(uri, request)
      Net::HTTP.start(uri.host, uri.port) do |http|
        http.request(request)
      end
    end
  end
end
