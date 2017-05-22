# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'football_ruby/version'

Gem::Specification.new do |spec|
  spec.name          = 'football_ruby'
  spec.version       = FootballRuby::VERSION
  spec.authors       = ['Said Kaldybaev']
  spec.email         = ['said.kaldybaev@gmail.com']

  spec.summary       = %q{football-data.org API wrapper in ruby}
  spec.description   = %q{football-data.org API wrapper in ruby}
  spec.homepage      = 'https://github.com/Saidbek/football_ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
end
