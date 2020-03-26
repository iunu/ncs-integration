require 'ncs_analytics/client/harvest'
require 'ncs_analytics/client/item'

module NcsAnalytics
  class Client
    def harvest
      @harvest ||= NcsAnalytics::Harvest.new
    end

    def item
      @item ||= NcsAnalytics::Item.new
    end
  end
end
