require 'spec_helper'

describe NCS do
  it 'has a version number' do
    expect(described_class::VERSION).not_to be nil
  end

  it 'accepts a configuration, requires a complete configuration' do
    described_class.configure do |config|
      config.api_key = nil
    end

    expect(described_class.configuration.be_incomplete).to be_truthy
  end
end
