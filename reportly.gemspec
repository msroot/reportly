# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reportly/version'

Gem::Specification.new do |spec|
  spec.name          = "reportly"
  spec.version       = Reportly::VERSION
  spec.authors       = ["Yannis Kolovos"]
  spec.email         = ["yannis.kolovos@gmail.com"]
  spec.summary       = "Reports for Active record objects"
  spec.description   = "Generates tables from Active record objects"
  spec.homepage      = "http://johnkolovos.blogspot.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"  
  spec.add_development_dependency "rspec", "~> 3.2.0"
  spec.add_development_dependency "guard", "~> 2.12.5"
  spec.add_development_dependency "guard-rspec", "~> 4.5.0"
  spec.add_development_dependency "sqlite3", "~> 1.3.10"
  spec.add_development_dependency "coveralls", "~> 0.7.11"  
  spec.add_runtime_dependency "rails", "~> 4.1.8"

end
