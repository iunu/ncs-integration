module ConfigurationHelper
  def configure_client
    CCA.configure do |config|
      config.api_key = $spec_credentials['api_key']
      config.uri = $spec_credentials['uri']
      config.debug = false
      config.debug = $spec_credentials['debug'] if $spec_credentials['debug']
    end
  end
end
