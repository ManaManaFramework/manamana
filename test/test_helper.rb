# Add the gem's lib folder to the load path
$:.unshift File.expand_path("../../lib", __FILE__)

require "bundler/setup"
require "minitest/autorun"
require "minitest/colorize"
require "manamana"