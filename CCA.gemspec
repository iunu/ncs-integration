# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'CCA/version'

Gem::Specification.new do |spec|
  spec.name          = 'CCA'
  spec.version       = CCA::VERSION
  spec.authors       = ['Joseph B. Ottinger']
  spec.email         = ['joseph@autumncode.com']

  spec.summary       = %q{Pull and push lab data between a LIMS and CCA}
  spec.description   = %q{A simple gem to pull lab tests and push results to CCA}
  spec.homepage      = 'https://420tech.org'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_dependency 'httparty'
  spec.add_dependency 'bundler'
  spec.add_dependency 'rake'
  spec.add_dependency 'rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'webmock'
end
