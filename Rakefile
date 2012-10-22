# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "schrodingers-cat"
  gem.homepage = "http://github.com/caleon/schrodinger"
  gem.license = "MIT"
  gem.summary = %Q{A convenience utility for dealing with the unknown state of an object's existence in order to avoid common code inelegance.}
  gem.description = <<-DESC
    The Schrodinger's Cat gem is a library that boasts neither novelty or
    ingenuity, just the potential for writing more efficient code when it comes
    to (and we've all been there) dealing with the ubiquitous cases wherein the
    existence (or nil'ness) of the object referenced is ever in flux. To this
    end, Schrodinger's Cat defines Object-level methods designed for theses
    common cases.
  DESC
  gem.email = "caleon@gmail.com"
  gem.authors = ["caleon"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "Schrodinger's Cat #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
