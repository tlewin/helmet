require 'rake'
require 'rake/testtask'

task :default => [:test]

desc 'run tests'
Rake::TestTask.new(:test) do |test|
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end
