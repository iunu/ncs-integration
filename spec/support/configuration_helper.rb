require 'yaml'

spec_credentials = { # rubocop:disable Lint/UselessAssignment
  api_key: ENV['NCS_TEST_API_KEY'],
  uri: ENV['NCS_TEST_API_URI']
}.freeze

spec_credentials = YAML.load_file('./spec/test_credentials.yml').transform_keys(&:to_sym) if File.file?('./spec/test_credentials.yml') # rubocop:disable Layout/LineLength, Lint/UselessAssignment

module ConfigurationHelper
  def configure_client
    NcsAnalytics.configure do |config|
      config.api_key = spec_credentials.fetch(:api_key)
      config.uri = spec_credentials.fetch(:uri)
      config.debug = spec_credentials.has_key?(:debug)
    end
  end
end
