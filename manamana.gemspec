# -*- encoding: utf-8 -*-
require File.expand_path('../lib/manamana/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Mark Maglana"]
  gem.email         = ["mmaglana@gmail.com"]
  gem.description   = %q{Capture project requirements better}
  gem.summary       = %q{Organize your project's requirements and their associated test cases in a way that makes sense to your organization. Then keep track of the status of each as your project progresses.}
  gem.homepage      = "https://github.com/relaxdiego/manamana"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "manamana"
  gem.require_paths = ["lib"]
  gem.version       = ManaMana::VERSION
end
