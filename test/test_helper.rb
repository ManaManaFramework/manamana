# Add the gem's lib folder to the load path
$:.unshift File.expand_path("../../lib", __FILE__)

require "bundler/setup"
require "minitest/autorun"
require "minitest/colorize"
require "manamana"

def get_or_create_tmp_dir
  root_dir = get_root_dir
  Dir.mkdir 'tmp' unless root_dir.entries.include? 'tmp'
  Dir.chdir 'tmp'
  Dir.new(Dir.pwd)  
end

def get_root_dir
  unless Dir.new(Dir.pwd).entries.include? 'manamana.gemspec'
    Dir.chdir '..'
  end
  Dir.new(Dir.pwd)  
end