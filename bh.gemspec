# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bh/version'

Gem::Specification.new do |spec|
  spec.name          = "bh"
  spec.version       = Bh::VERSION
  spec.authors       = ["Claudio Baccigalupo"]
  spec.email         = ["claudio@fullscreen.net"]
  spec.description   = %q{Bh - Bootstrap Helpers}
  spec.summary       = %q{Bh provides a set of powerful helpers that
    streamlines the use of Bootstrap components in Rails views.}
  spec.homepage      = "http://github.com/Fullscreen/bh"
  spec.license       = "MIT"

  spec.required_ruby_version = '>= 1.9.3'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport'
  spec.add_dependency 'actionpack'

  # For development / Code coverage / Documentation
  spec.add_development_dependency 'bundler' #, '~> 1.0'
  spec.add_development_dependency 'rspec' #, '~> 2.0'
  spec.add_development_dependency 'rake' #, '~> 10.0'
  spec.add_development_dependency 'yard' #, '~> 0.8.0'
  spec.add_development_dependency 'coveralls' #, '~> 0.7.0'
  spec.add_development_dependency 'activemodel'
end