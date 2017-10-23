$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "right_manager/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "right_manager"
  s.version     = RightManager::VERSION
  s.authors     = ["andystark86"]
  s.email       = ["andreas.stark@prosiebensat1.com"]
  s.homepage    = "http://nohompage.de"
  s.summary     = "RightManager"
  s.description = "Description of RightManager."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.4"
  #s.add_dependency "rails", "~> 5.0.1"
  s.add_dependency "jquery-rails"
  s.add_dependency "bootstrap-sass"
  s.add_dependency 'haml-rails'
  s.add_dependency 'kaminari'
  s.add_dependency 'bootstrap-kaminari-views'

  s.add_development_dependency "sqlite3"
end
