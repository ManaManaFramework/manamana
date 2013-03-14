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


namespace :rdsl do

  desc "Compiles the Requirements DSL lexer"
  task :compile_lexer do |t|
    `ragel -R src/rdsl/lexer.rl -o lib/manamana/rdsl/lexer.rb`
  end

  desc "Compiles the Requirements DSL parser"
  task :compile_parser do |t|
    `racc src/rdsl/parser.y -o lib/manamana/rdsl/parser.rb`
  end

end


namespace :tdsl do

  desc "Compiles the Test Case DSL lexer"
  task :compile_lexer do |t|
    `ragel -R src/tdsl/lexer.rl -o lib/manamana/tdsl/lexer.rb`
  end

  desc "Compiles the Test Case DSL parser"
  task :compile_parser do |t|
    `racc src/tdsl/parser.y -o lib/manamana/tdsl/parser.rb`
  end

end