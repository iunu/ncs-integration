require 'spec_helper'

describe NCS do
  it 'has a version number' do
    expect(NCS::VERSION).not_to be nil
  end

  it 'accepts a configuration, requires a complete configuration' do
    NCS.configure do |config|
      config.api_key = nil
    end

    expect(NCS.configuration.incomplete?).to be_truthy
  end
end
