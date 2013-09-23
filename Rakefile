require 'rake'
require 'rake/testtask'

require './lib/helmet/version'

desc 'run tests'
Rake::TestTask.new(:test) do |test|
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

namespace :gem do
  desc 'build gem file'
  task :build do
    system 'gem build helmet.gemspec'
  end

  desc 'install gem file'
  task :install do
    system "gem install --local helmet-#{Helmet::VERSION}.gem"
  end
end

desc 'build and install gem file'
task :gem => ['gem:build', 'gem:install']

task :default => [:test]