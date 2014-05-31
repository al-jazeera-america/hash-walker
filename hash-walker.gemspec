# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hash_walker/version'

Gem::Specification.new do |spec|
  spec.name          = "hash-walker"
  spec.version       = HashWalker::VERSION
  spec.authors       = ["Gal Steinitz"]
  spec.email         = ["gal@steinitz.com"]
  spec.summary       = %q{Walk a hash like a hash walker would}
  spec.description   = %q{a Ruby DSL for walking through a Hash and processing it}
  spec.homepage      = "https://github.com/al-jazeera-america/hash-walker"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_runtime_dependency 'activesupport'
end
