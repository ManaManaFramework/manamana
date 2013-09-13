source 'https://rubygems.org'

# Specify your gem's dependencies in manamana.gemspec
gemspec

group :test do
  gem 'coveralls', require: false
end

group :development do
  gem "minitest"
  gem "minitest-colorize", :git => 'git://github.com/sobrinho/minitest-colorize.git', :branch => 'master'
  gem 'rb-fsevent', '~> 0.9'
  gem "guard"
  gem "guard-rake"
  gem "guard-minitest"
  gem "guard-process"
  gem 'ruby_gntp'
  gem "racc"
  gem "debugger"
  gem "pry"
  gem 'json', '~> 1.7.7'
end