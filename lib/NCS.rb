require 'httparty'

require 'NCS/version'
require 'NCS/configuration'
require 'NCS/errors'
require 'NCS/constants'
require 'NCS/client'

module NCS
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
