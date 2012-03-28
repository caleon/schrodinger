$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "schrodinger/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "schrodinger"
  s.version     = Schrodinger::VERSION
  s.authors     = ["caleon"]
  s.email       = ["caleon@gmail.com"]
  s.homepage    = "http://github.com/caleon/schrodinger"
  s.summary     = %q{A convenience utility for dealing with the unknown state of an object's existence in order to avoid }
  s.description = %q{The Schrodinger's Cat gem is a library that boasts neither novelty or ingeunity, just the potential for writing more efficient code when it comes to (and we've all been there) dealing with the ubiquitous cases wherein the existence (or nil'ness) of the object referenced is ever in flux. To this end, Schrodinger's Cat defines Object-level methods designed for theses common cases.}

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'activesupport', '>= 3.1.1'
  s.add_development_dependency "rails", ">= 3.1.1"
  s.add_dependency 'core_utilities', '~> 0.1.3'

  s.add_development_dependency "sqlite3"
end
