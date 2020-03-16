require 'httparty'

require 'NCS/version'
require 'NCS/configuration'
require 'NCS/errors'
require 'NCS/client'

module NCS
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure(&_block)
    yield configuration
  end
end
