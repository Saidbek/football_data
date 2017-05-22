$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'football_ruby'
require 'webmock/rspec'
require 'vcr'

Dir[File.expand_path('support/**/*.rb', File.dirname(__FILE__))].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

FootballRuby.configure do |config|
  config.api_token = '31d3d417db12416abbb83e1e3f0a123'
end

WebMock.disable_net_connect!(allow_localhost: true)
