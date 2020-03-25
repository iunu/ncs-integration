$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'webmock/rspec'
require 'ncs_analytics'

Dir[File.expand_path(File.join(File.dirname(__FILE__), 'support', '**', '*.rb'))].each {|f| require f } # rubocop:disable Lint/NonDeterministicRequireOrder

RSpec.configure do |config|
  config.include ConfigurationHelper
end
