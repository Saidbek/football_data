module Requests
  module Helpers
    def parse_json(response)
      JSON.parse(response.body)
    end

    def fixture(name)
      path = File.expand_path "../fixtures/#{ name }", File.dirname(__FILE__)
      File.read path
    end
  end
end
