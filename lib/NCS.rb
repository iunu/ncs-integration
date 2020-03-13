require 'httparty'

require 'ncs/version'
require 'ncs/configuration'
require 'ncs/errors'
require 'ncs/client'

module NCS
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure(&_block)
    yield configuration
  end
end
