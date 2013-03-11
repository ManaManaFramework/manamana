#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake/testtask'
 
Rake::TestTask.new do |t|
  t.libs << 'lib/manamana'
  t.test_files = FileList[
                           'test/lib/manamana/*_test.rb',
                           'test/lib/rsyntax/*_test.rb'
                         ]
  t.verbose = false
end
 
task :default => :test