# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'promet/version'

Gem::Specification.new do |spec|
  spec.name          = "promet"
  spec.version       = Promet::VERSION
  spec.authors       = ["Oto Brglez"]
  spec.email         = ["otobrglez@gmail.com"]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  %w{oj httparty georuby geocoder rgeo}.each do |g|
    spec.add_dependency g
  end

  spec.add_development_dependency "bundler", "~> 1.3"
  %w{rake rspec webmock spork guard guard-rspec}.each do |g|
    spec.add_development_dependency g
  end

end
