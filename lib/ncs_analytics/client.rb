require 'ncs_analytics/client/harvest'
require 'ncs_analytics/client/item'
require 'ncs_analytics/client/package'
require 'ncs_analytics/client/plant_batch'
require 'ncs_analytics/client/plant'

module NcsAnalytics
  class Client
    def harvest
      @harvest ||= NcsAnalytics::Harvest.new
    end

    def item
      @item ||= NcsAnalytics::Item.new
    end

    def package
      @package ||= NcsAnalytics::Package.new
    end

    def plant_batch
      @plant_batch ||= NcsAnalytics::PlantBatch.new
    end

    def plant
      @plant ||= NcsAnalytics::Plant.new
    end
  end
end
