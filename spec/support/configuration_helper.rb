module ConfigurationHelper
  def configure_client
    NcsAnalytics.configure do |config|
      config.api_key = $spec_credentials.fetch('api_key') # rubocop:disable Style/GlobalVars
      config.uri = $spec_credentials.fetch('uri') # rubocop:disable Style/GlobalVars
      config.debug = $spec_credentials.has_key?('debug') # rubocop:disable Style/GlobalVars
    end
  end
end
