require 'spec_helper'

describe NcsAnalytics::Client do
  subject { described_class.new }

  before { configure_client }

  describe '#harvest' do
    it { expect(subject.harvest).to be_a(NcsAnalytics::Harvest) }
  end

  describe '#item' do
    it { expect(subject.item).to be_a(NcsAnalytics::Item) }
  end

  describe '#package' do
    it { expect(subject.package).to be_a(NcsAnalytics::Package) }
  end

  describe '#plant_batch' do
    it { expect(subject.plant_batch).to be_a(NcsAnalytics::PlantBatch) }
  end

  describe '#plant' do
    it { expect(subject.plant).to be_a(NcsAnalytics::Plant) }
  end

  describe '#room' do
    it { expect(subject.room).to be_a(NcsAnalytics::Room) }
  end

  describe '#sale' do
    it { expect(subject.sale).to be_a(NcsAnalytics::Sale) }
  end

  describe '#strain' do
    it { expect(subject.strain).to be_a(NcsAnalytics::Strain) }
  end

  describe '#transfer' do
    it { expect(subject.transfer).to be_a(NcsAnalytics::Transfer) }
  end
end
