![Travis Master](https://travis-ci.org/Saidbek/football_ruby.svg?branch=master)
# FootballRuby

football-data.org API Container for Ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'football_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install football_ruby
    
## Configuration

To use this gem you have to have an account at [football-data.org](http://football-data.org/client/register)
There are two ways of configuration.

1. Block

```ruby
FootballRuby.configure do |config|
  config.api_token = API_TOKEN
end
```

2. Inline

```ruby
FootballRuby.api_token = API_TOKEN
```

## Usage

More about filters, structure and API: [football-data.org](http://api.football-data.org/documentation)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Saidbek/football_ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
