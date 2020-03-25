require 'spec_helper'

describe NcsAnalytics::Base do
  let(:validation_hash) do
    {
      Name: :string,
      Quantity: :numeric
    }
  end

  subject { described_class.new(:items, validation_hash, NcsAnalytics.configuration.to_h) } # rubocop:disable RSpec/LeadingSubject

  before { configure_client }

  describe '#sign_in', only: 'Check' do
    context 'when no config is provided' do
      it 'raises an MissingConfiguration exception' do
        NcsAnalytics.configure do |config|
          config.api_key = nil
        end

        expect { described_class.new(:items) }.to raise_error(NcsAnalytics::Errors::MissingConfiguration)
      end
    end

    it 'does not raise an exception when config is complete' do
      NcsAnalytics.configure do |config|
        config.api_key = 'iamthetrueking'
        config.uri = 'https://targeryan'
      end

      expect { described_class.new(:items) }.not_to raise_error
    end
  end

  describe '#valid?' do
    it 'raises an InvalidPayload exception' do
      expect { subject.send(:valid?, Quantity: 1) }.to raise_error(NcsAnalytics::Errors::InvalidPayload)
    end

    it 'does not raise an InvalidPayload' do
      expect { subject.send(:valid?, Name: 'Something', Quantity: 1) }.not_to raise_error
    end
  end

  describe '#get' do
    before do
      stub_request(:get, 'https://vendortest-posapi.ncsanalytics.com/pos/items/v1/all')
        .with(headers: { 'Content-Type': 'application/json' })
        .to_return(body: '{}')
    end

    it 'calls the indicated path with the setted resource' do # rubocop:disable RSpec/MultipleExpectations
      allow_any_instance_of(described_class).to receive(:request).and_return(status: 200, body: {})

      expect { subject.get(:all) }.not_to raise_error

      expect(subject).to have_received(:request) # rubocop:disable RSpec/SubjectStub
    end
  end

  describe '#post' do
    before do
      stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/items/v1/create')
        .with(headers: { 'Content-Type': 'application/json' })
        .to_return(body: '{}')
    end

    it 'calls the indicated path with the setted resource' do # rubocop:disable RSpec/MultipleExpectations
      allow_any_instance_of(described_class).to receive(:request).and_return(status: 200, body: {})

      expect { subject.post(:create, {}) }.not_to raise_error

      expect(subject).to have_received(:request) # rubocop:disable RSpec/SubjectStub
    end
  end

  describe '#request' do
    context 'when a 400 is returned' do
      it 'raises a BadRequest exception' do
        stub_request(:get, 'https://vendortest-posapi.ncsanalytics.com/pos/items/v1/all')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 400, body: '{}')

        expect { subject.send(:request, :all) }.to raise_error(NcsAnalytics::Errors::BadRequest)
      end
    end

    context 'when a 401 is returned' do
      it 'raises an Unauthorized exception' do
        stub_request(:get, 'https://vendortest-posapi.ncsanalytics.com/pos/items/v1/all')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 401, body: '{}')

        expect { subject.send(:request, :all) }.to raise_error(NcsAnalytics::Errors::Unauthorized)
      end
    end

    context 'when a 403 is returned' do
      it 'raises a Forbidden exception' do
        stub_request(:get, 'https://vendortest-posapi.ncsanalytics.com/pos/items/v1/all')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 403, body: '{}')

        expect { subject.send(:request, :all) }.to raise_error(NcsAnalytics::Errors::Forbidden)
      end
    end

    context 'when a 404 is returned' do
      it 'raises a NotFound exception' do
        stub_request(:get, 'https://vendortest-posapi.ncsanalytics.com/pos/items/v1/else')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 404, body: '{}')

        expect { subject.send(:request, :else) }.to raise_error(NcsAnalytics::Errors::NotFound)
      end
    end

    context 'when a 429 is returned' do
      it 'raises a TooManyRequests exception' do
        stub_request(:get, 'https://vendortest-posapi.ncsanalytics.com/pos/items/v1/all')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 429, body: '{}')

        expect { subject.send(:request, :all) }.to raise_error(NcsAnalytics::Errors::TooManyRequests)
      end
    end

    context 'when a 500 is returned' do
      it 'raises a InternalServerError exception' do
        stub_request(:get, 'https://vendortest-posapi.ncsanalytics.com/pos/items/v1/all')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')

        expect { subject.send(:request, :all) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end

    it 'returns the body' do
      stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/items/v1/create')
        .with(headers: { 'Content-Type': 'application/json' })
        .to_return(status: 201, body: '{ Id: 1, Name: "CannAPI" }')

      expect { subject.send(:request, :create, :post, { Name: 'CannAPI' }) }.not_to raise_error
    end
  end
end
