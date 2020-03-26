require 'ncs_analytics/resource/harvest'
require 'ncs_analytics/resource/item'
require 'ncs_analytics/resource/package'
require 'ncs_analytics/resource/plant_batch'
require 'ncs_analytics/resource/plant'
require 'ncs_analytics/resource/room'
require 'ncs_analytics/resource/sale'
require 'ncs_analytics/resource/strain'
require 'ncs_analytics/resource/transfer'
require 'ncs_analytics/resource/test'

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

    def room
      @room ||= NcsAnalytics::Room.new
    end

    def sale
      @sale ||= NcsAnalytics::Sale.new
    end

    def strain
      @strain ||= NcsAnalytics::Strain.new
    end

    def transfer
      @transfer ||= NcsAnalytics::Transfer.new
    end

    def test
      @test ||= NcsAnalytics::Test.new
    end
  end
end
