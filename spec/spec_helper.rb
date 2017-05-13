$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'football_ruby'
require 'webmock/rspec'

Dir[File.expand_path('support/**/*.rb', File.dirname(__FILE__))].each { |f| require f }

RSpec.configure do |config|
  config.include Requests::Helpers
end

WebMock.disable_net_connect!
