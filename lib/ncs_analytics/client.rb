require 'ncs_analytics/resources/harvest'
require 'ncs_analytics/resources/item'
require 'ncs_analytics/resources/package'
require 'ncs_analytics/resources/plant_batch'
require 'ncs_analytics/resources/plant'
require 'ncs_analytics/resources/room'
require 'ncs_analytics/resources/sale'
require 'ncs_analytics/resources/strain'
require 'ncs_analytics/resources/transfer'
require 'ncs_analytics/resources/test'

module NcsAnalytics
  class Client
    def harvest
      @harvest ||= NcsAnalytics::Resources::Harvest.new
    end

    def item
      @item ||= NcsAnalytics::Resources::Item.new
    end

    def package
      @package ||= NcsAnalytics::Resources::Package.new
    end

    def plant_batch
      @plant_batch ||= NcsAnalytics::Resources::PlantBatch.new
    end

    def plant
      @plant ||= NcsAnalytics::Resources::Plant.new
    end

    def room
      @room ||= NcsAnalytics::Resources::Room.new
    end

    def sale
      @sale ||= NcsAnalytics::Resources::Sale.new
    end

    def strain
      @strain ||= NcsAnalytics::Resources::Strain.new
    end

    def transfer
      @transfer ||= NcsAnalytics::Resources::Transfer.new
    end

    def test
      @test ||= NcsAnalytics::Resources::Test.new
    end
  end
end
