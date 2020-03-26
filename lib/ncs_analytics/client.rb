require 'ncs_analytics/client/harvest'

module NcsAnalytics
  class Client
    def harvest
      @harvest ||= NcsAnalytics::Harvest.new
    end
  end
end
