source 'https://rubygems.org'

# Specify your gem's dependencies in manamana.gemspec
gemspec

group :test do
  gem 'rake'
  gem "minitest"
  gem "minitest-colorize", :git => 'git://github.com/sobrinho/minitest-colorize.git', :branch => 'master'
  gem 'coveralls', require: false
  gem 'json', '~> 1.7.7'
end

group :development do
  gem 'rb-fsevent', '~> 0.9'
  gem "guard"
  gem "guard-rake"
  gem "guard-minitest"
  gem "guard-process"
  gem 'ruby_gntp'
  gem "debugger"
  gem "pry"
end