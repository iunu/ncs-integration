lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ncs_analytics/version'

Gem::Specification.new do |spec|
  spec.name          = 'ncs_analytics'
  spec.version       = NcsAnalytics::VERSION
  spec.authors       = ['Joseph B. Ottinger', 'Carlos Betancourt Carrero']
  spec.email         = ['joseph@autumncode.com', 'cbetancourt@artemisag.com']

  spec.summary       = 'Pull and push lab data between a LIMS and NCS'
  spec.description   = 'A simple gem to pull lab tests and push results to NCS'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject {|f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^exe/}) {|f| File.basename(f) }
  spec.require_paths = ['lib']

  # Runtime dependencies
  spec.add_dependency 'bundler'
  spec.add_dependency 'httparty'

  # Development dependencies
  spec.add_development_dependency 'ci_reporter'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-rubocop'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'terminal-notifier'
  spec.add_development_dependency 'terminal-notifier-guard'
  spec.add_development_dependency 'webmock'
end
