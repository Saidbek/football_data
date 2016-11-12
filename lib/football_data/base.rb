require 'net/http'
require 'football_data/errors'

module FootballData
  class Base
    API_ENDPOINT = 'http://api.football-data.org'
    API_VERSION  = 'v1'

    def build_headers(params)
      {
        'X-Auth-Token' => '31d3d417db12416abbb83e1e3f0a47a9',
        'X-Response-Control' => 'full'
      }.merge(params)
    end

    def get_request(path, params={})
      uri = build_uri(path)
      request = Net::HTTP::Get.new(uri, build_headers(params))

      response = Net::HTTP.start(uri.host, uri.port) do |http|
        http.request(request)
      end

      if response.kind_of? Net::HTTPSuccess
        response
      else
        raise FootballData::ResponseError.new(response)
      end
    end

    def build_uri(path)
      URI "#{API_ENDPOINT}/#{API_VERSION}/#{path}"
    end
  end
end
