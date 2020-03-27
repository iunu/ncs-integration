require 'spec_helper'

describe NcsAnalytics::Resources::Sale do
  subject { described_class.new }

  before { configure_client }

  it 'has a resource' do
    expect(subject.resource).to eq(:sales)
  end

  describe '#all' do
    it 'does not raise an error' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:receipts).and_return(status: 200, body: {})
      expect { subject.all }.not_to raise_error
    end

    it 'calls the GET endpoint' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:receipts).and_return(status: 200, body: {})
      subject.all
    end
  end

  describe '#create' do
    let(:payload) do
      {
        SalesDateTime: '2018-05-04T10:30:23.000',
        SalesCustomerType: 'Consumer',
        PatientLicenseNumber: 'LIC-1234',
        CaregiverLicenseNumber: 'CGLIC-9876',
        IdentificationMethod: nil,
        Transactions: [
          {
            PackageLabel: 'ABCDEF012345670000010330',
            Quantity: 2.0,
            UnitOfMeasure: 'Ounces',
            TotalAmount: 8.79
          },
          {
            PackageLabel: 'ABCDEF012345670000010335',
            Quantity: 3.0,
            UnitOfMeasure: 'Ounces',
            TotalAmount: 19.34
          }
        ]
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:receipts, [payload]).and_return(status: 200, body: {})
        subject.create([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:receipts, [payload]).and_return(status: 200, body: {})
        subject.create(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/sales/v1/receipts')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.create(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end
end
