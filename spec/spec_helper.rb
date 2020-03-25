require 'yaml'

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

if File.file?('./spec/test_credentials.yml') # rubocop:disable Style/ConditionalAssignment
  $spec_credentials = YAML.load_file('./spec/test_credentials.yml') # rubocop:disable Style/GlobalVars
else
  $spec_credentials = { # rubocop:disable Style/GlobalVars
    'api_key': ENV['NCS_TEST_API_KEY'],
    'uri': ENV['NCS_TEST_API_URI']
  }.freeze
end

require 'webmock/rspec'
require 'ncs_analytics'

Dir[File.expand_path(File.join(File.dirname(__FILE__), 'support', '**', '*.rb'))].each {|f| require f } # rubocop:disable Lint/NonDeterministicRequireOrder

RSpec.configure do |config|
  config.include ConfigurationHelper
end
