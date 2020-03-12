module ConfigurationHelper
  def configure_client
    NCS.configure do |config|
      config.api_key = $spec_credentials.fetch('api_key') # rubocop:disable Style/GlobalVars
      config.uri = $spec_credentials.fetch('uri') # rubocop:disable Style/GlobalVars
      config.debug = $spec_credentials.fetch('debug') if $spec_credentials.fetch('debug') # rubocop:disable Style/GlobalVars
    end
  end
end
