require 'net/http'
require 'football_data/errors'

module FootballData
  class Base
    API_ENDPOINT = 'http://api.football-data.org'
    API_VERSION = 'v1'
    API_LIVE = 'http://soccer-cli.appspot.com'

    def get(path, params={})
      uri = URI("#{API_ENDPOINT}/#{API_VERSION}/#{path}")

      request = build_request(uri, build_headers(params))
      build_response(uri, request)
    end

    def get_live_scores
      uri = URI("#{API_LIVE}/")

      request = build_request(uri)
      build_response(uri, request)
    end

    private

    def build_headers(params)
      {
        'X-Auth-Token' => '31d3d417db12416abbb83e1e3f0a47a9',
        'X-Response-Control' => 'full'
      }.merge(params)
    end

    def build_request(uri, headers={})
      Net::HTTP::Get.new(uri, headers)
    end

    def build_response(uri, request)
      response = Net::HTTP.start(uri.host, uri.port) do |http|
        http.request(request)
      end

      if response.kind_of? Net::HTTPSuccess
        response
      else
        raise FootballData::ResponseError.new(response)
      end
    end
  end
end
