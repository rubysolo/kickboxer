# -*- encoding: utf-8 -*-
require File.expand_path('../lib/kickboxer/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Solomon White"]
  gem.email         = ["rubysolo@gmail.com"]
  gem.description   = %q{Kickboxer}
  gem.summary       = %q{Kickboxer is a Ruby library for accessing the FullContact API}
  gem.homepage      = "https://github.com/rubysolo/kickboxer"

  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "kickboxer"
  gem.require_paths = ["lib"]
  gem.version       = Kickboxer::VERSION
end
