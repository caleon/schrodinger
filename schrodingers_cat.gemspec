# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "schrodingers_cat/version"

Gem::Specification.new do |s|
  s.name        = "schrodingers_cat"
  s.version     = SchrodingersCat::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Caleon Chun"]
  s.email       = ["colin@juscribe.com"]
  s.homepage    = "http://www.juscribe.com/u/colin"
  s.summary     = %q{A convenience utility for dealing with the unknown state of an object's existence in order to avoid }
  s.description = %q{The Schrodinger's Cat gem is a library that boasts neither novelty or ingeunity, just the potential for writing more efficient code when it comes to (and we've all been there) dealing with the ubiquitous cases wherein the existence (or nil'ness) of the object referenced is ever in flux. To this end, Schrodinger's Cat defines Object-level methods designed for theses common cases.}

  s.rubyforge_project = "schrodingers_cat"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
