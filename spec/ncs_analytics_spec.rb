require 'spec_helper'

describe NcsAnalytics do
  it 'has a version number' do
    expect(described_class::VERSION).not_to be nil
  end

  it 'accepts a configuration, requires a complete configuration' do
    described_class.configure do |config|
      config.api_key = nil
    end

    expect(described_class.configuration.incomplete?).to be_truthy # rubocop:disable RSpec/PredicateMatcher
  end

  it 'has the models methods' do
    expect(described_class).to respond_to(:extract_keys)
  end
end
