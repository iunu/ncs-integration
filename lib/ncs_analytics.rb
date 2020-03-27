require 'ncs_analytics/version'
require 'ncs_analytics/configuration'
require 'ncs_analytics/errors'
require 'ncs_analytics/resource'
require 'ncs_analytics/client'

module NcsAnalytics
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure(&_block)
    yield configuration
  end
end
