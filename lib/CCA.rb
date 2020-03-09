require 'httparty'

require 'CCA/version'
require 'CCA/configuration'
require 'CCA/errors'
require 'CCA/constants'
require 'CCA/client'

module CCA
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure(&block)
    yield configuration
  end
end
