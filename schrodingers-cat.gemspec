# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "schrodingers-cat"
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["caleon"]
  s.date = "2012-10-23"
  s.description = "    The Schrodinger's Cat gem is a library that boasts neither novelty or\n    ingenuity, just the potential for writing more efficient code when it comes\n    to (and we've all been there) dealing with the ubiquitous cases wherein the\n    existence (or nil'ness) of the object referenced is ever in flux. To this\n    end, Schrodinger's Cat defines Object-level methods designed for theses\n    common cases.\n"
  s.email = "caleon@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    "CHANGELOG.rdoc",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "init.rb",
    "lib/schrodingers-cat.rb",
    "lib/schrodingers/cat.rb",
    "lib/schrodingers_cat/core_ext.rb",
    "lib/schrodingers_cat/dependencies.rb",
    "lib/schrodingers_cat/schrodingers_cat.rb",
    "lib/tasks/schrodinger_tasks.rake",
    "schrodingers-cat.gemspec",
    "spec/schrodingers-cat_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/caleon/schrodinger"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "A convenience utility for dealing with the unknown state of an object's existence in order to avoid common code inelegance."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.11.0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.4"])
      s.add_development_dependency(%q<i18n>, [">= 0"])
      s.add_development_dependency(%q<activesupport>, [">= 3.1.0"])
      s.add_development_dependency(%q<justools>, ["~> 1.2.0"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.11.0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
      s.add_dependency(%q<i18n>, [">= 0"])
      s.add_dependency(%q<activesupport>, [">= 3.1.0"])
      s.add_dependency(%q<justools>, ["~> 1.2.0"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.11.0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, [">= 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
    s.add_dependency(%q<i18n>, [">= 0"])
    s.add_dependency(%q<activesupport>, [">= 3.1.0"])
    s.add_dependency(%q<justools>, ["~> 1.2.0"])
  end
end

