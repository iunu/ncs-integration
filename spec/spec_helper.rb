require 'yaml'

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
$spec_credentials = YAML.load_file('./spec/test_credentials.yml') # rubocop:disable Style/GlobalVars

require 'webmock/rspec'
require 'NCS'

Dir[File.expand_path(File.join(File.dirname(__FILE__), 'support', '**', '*.rb'))].each {|f| require f } # rubocop:disable Lint/NonDeterministicRequireOrder

RSpec.configure do |config|
  config.include ConfigurationHelper
end
