# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bh/version'

Gem::Specification.new do |spec|
  spec.name          = 'bh'
  spec.version       = Bh::VERSION
  spec.authors       = ['claudiob']
  spec.email         = ['claudio@fullscreen.net']
  spec.summary       = %q{Bootstrap Helpers}
  spec.description   = %q{ERB helpers to easily apply Boostrap to HTML elements.}
  spec.homepage      = 'http://github.com/Fullscreen/bh'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 0'
end