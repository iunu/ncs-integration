require 'spec_helper'

describe NcsAnalytics::Client do
  subject { described_class.new }

  before { configure_client }

  describe '#harvest' do
    it 'is an instance of NcsAnalytics::Harvest' do
      expect(subject.harvest).to be_a(NcsAnalytics::Harvest)
    end
  end
end
