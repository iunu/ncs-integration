module ConfigurationHelper
  def configure_client
    CCA.configure do |config|
      config.api_key  = $spec_credentials['api_key']
      config.url = $spec_credentials['user_key']
    end
  end
end
