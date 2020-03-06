require 'httparty'
#require 'Metrc/constants'
#require 'Metrc/errors'
#require 'Metrc/configuration'
#require 'Metrc/client'
require "CCA/version"

module CCA
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure(&block)
    yield configuration
  end
end
