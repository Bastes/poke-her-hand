$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "poker/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "poker"
  s.version     = RailsStars::VERSION
  s.authors     = ["Michel Bellevill"]
  s.email       = ["michel.belleville@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "Evaluates poker hands"
  s.description = "Written as an exercise, a poker hand evaluator"

  s.required_ruby_version     = '>= 1.9.3'

  s.files = Dir["lib/**/*"] + ["LICENSE.txt", "Rakefile", "README.markdown"]
  s.test_files = Dir["spec/**/*"]
end
