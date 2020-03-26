require 'spec_helper'

describe NcsAnalytics::Resources::Test do
  subject { described_class.new }

  before { configure_client }

  it 'has a resource' do
    expect(subject.resource).to eq(:tests)
  end

  describe '#anon' do
    it 'does not raise an error' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:anon).and_return(status: 200, body: {})
      expect { subject.anon }.not_to raise_error
    end

    it 'calls the GET endpoint' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:anon).and_return(status: 200, body: {})
      subject.anon
    end
  end

  describe '#what_is_my_ip' do
    it 'does not raise an error' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:whatismyip).and_return(status: 200, body: {})
      expect { subject.what_is_my_ip }.not_to raise_error
    end

    it 'calls the GET endpoint' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:whatismyip).and_return(status: 200, body: {})
      subject.what_is_my_ip
    end
  end

  describe '#ip' do
    it 'does not raise an error' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:whatismyip).and_return(status: 200, body: {})
      expect { subject.ip }.not_to raise_error
    end

    it 'calls the GET endpoint' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:whatismyip).and_return(status: 200, body: {})
      subject.ip
    end
  end

  describe '#auth' do
    it 'does not raise an error' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:auth).and_return(status: 200, body: {})
      expect { subject.auth }.not_to raise_error
    end

    it 'calls the GET endpoint' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:auth).and_return(status: 200, body: {})
      subject.auth
    end
  end
end
