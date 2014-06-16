$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "feeder/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "feeder"
  s.version     = Feeder::VERSION
  s.authors     = ["Sindre Moen"]
  s.email       = ["sindre@hyper.no"]
  s.homepage    = "http://github.com/hyperoslo/feeder"
  s.summary     = "Provides simple feed functionality through an engine"
  s.description = <<DESC
Feeder gives you a mountable engine that provides a route to a feed page in your
Ruby on Rails application.
DESC
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.0"
  s.add_dependency 'rails-observers'
  s.add_dependency 'kaminari'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry-rails"
  s.add_development_dependency "hirb-unicode"
  s.add_development_dependency "rspec-rails", '~> 2.x'
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "timecop"
  s.add_development_dependency "cancan"
end
