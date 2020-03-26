require 'spec_helper'

describe NcsAnalytics::Client do
  subject { described_class.new }

  before { configure_client }

  describe '#harvest' do
    it 'is an instance of NcsAnalytics::Harvest' do
      expect(subject.harvest).to be_a(NcsAnalytics::Harvest)
    end
  end

  describe '#item' do
    it 'is an instance of NcsAnalytics::Item' do
      expect(subject.item).to be_a(NcsAnalytics::Item)
    end
  end

  describe '#package' do
    it 'is an instance of NcsAnalytics::Package' do
      expect(subject.package).to be_a(NcsAnalytics::Package)
    end
  end

  describe '#plant_batch' do
    it 'is an instance of NcsAnalytics::Package' do
      expect(subject.plant_batch).to be_a(NcsAnalytics::PlantBatch)
    end
  end

  describe '#plant' do
    it 'is an instance of NcsAnalytics::Package' do
      expect(subject.plant).to be_a(NcsAnalytics::Plant)
    end
  end
end
