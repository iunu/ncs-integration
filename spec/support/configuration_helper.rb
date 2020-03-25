require 'yaml'

module ConfigurationHelper
  def configure_client
    credentials = {
      api_key: ENV['NCS_TEST_API_KEY'],
      uri: ENV['NCS_TEST_API_URI']
    }.freeze

    credentials = YAML.load_file('./spec/test_credentials.yml').transform_keys(&:to_sym) if File.file?('./spec/test_credentials.yml') # rubocop:disable Layout/LineLength

    NcsAnalytics.configure do |config|
      config.uri   = credentials.fetch(:uri)
      config.debug = credentials.has_key?(:debug)
      config.api_key = credentials.fetch(:api_key)
    end
  end
end
