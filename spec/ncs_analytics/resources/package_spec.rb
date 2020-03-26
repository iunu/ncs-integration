require 'spec_helper'

describe NcsAnalytics::Resources::Package do
  subject { described_class.new }

  before { configure_client }

  it 'has a resource' do
    expect(subject.resource).to eq(:packages)
  end

  describe '#active' do
    it 'does not raise an error' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:active).and_return(status: 200, body: {})
      expect { subject.active }.not_to raise_error
    end

    it 'calls the GET endpoint' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:active).and_return(status: 200, body: {})
      subject.active
    end
  end

  describe '#inactive' do
    it 'does not raise an error' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:inactive).and_return(status: 200, body: {})
      expect { subject.inactive }.not_to raise_error
    end

    it 'calls the GET endpoint' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:inactive).and_return(status: 200, body: {})
      subject.inactive
    end
  end

  describe '#onhold' do
    it 'does not raise an error' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:onhold).and_return(status: 200, body: {})
      expect { subject.onhold }.not_to raise_error
    end

    it 'calls the GET endpoint' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:onhold).and_return(status: 200, body: {})
      subject.onhold
    end
  end

  describe '#create' do
    let(:payload) do
      {
        Label: 'ABCDEF0123456700000202011',
        RoomName: nil,
        ProductName: 'Buds',
        Quantity: 16.0,
        UnitOfMeasureName: 'Ounces',
        IsProductionBatch: false,
        ProductionBatchNumber: nil,
        ProductRequiresRemediation: false,
        PackagedDate: '2015-12-15',
        Ingredients: [
          {
            Label: 'ABCDEF012345670000010041',
            Quantity: 8.0,
            UnitOfMeasureName: 'Ounces'
          },
          {
            Label: 'ABCDEF012345670000010042',
            Quantity: 8.0,
            UnitOfMeasureName: 'Ounces'
          }
        ]
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:create, [payload]).and_return(status: 200, body: {})
        subject.create([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:create, [payload]).and_return(status: 200, body: {})
        subject.create(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/packages/v1/create')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.create(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end

  describe '#create_plantings' do
    let(:payload) do
      {
        Label: 'ABCDEF012345670000020201',
        Quantity: 2.0,
        UnitOfMeasureName: 'Ounces',
        PlantBatchName: 'AK-47 Clone 1/31/2017',
        PlantBatchTypeName: 'Clone',
        PlantCount: 1,
        RoomName: 'Plant Batch Room',
        StrainName: 'AK-47',
        PlantedDate: '2017-01-31T00:00:00Z',
        FinishedDate: '0001-01-01T00:00:00Z'
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with('create/plantings', [payload]).and_return(status: 200, body: {})
        subject.create_plantings([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with('create/plantings', [payload]).and_return(status: 200, body: {})
        subject.create_plantings(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/packages/v1/create/plantings')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.create_plantings(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end

  describe '#change_item' do
    let(:payload) do
      {
        Label: 'ABCDEF012345670000020201',
        ProductName: 'Shake'
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with('change/item', [payload]).and_return(status: 200, body: {})
        subject.change_item([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with('change/item', [payload]).and_return(status: 200, body: {})
        subject.change_item(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/packages/v1/change/item')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.change_item(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end

  describe '#remediate' do
    let(:payload) do
      {
        Label: 'ABCDEF012345670000020201',
        RemediationMethodName: 'Further Drying',
        RemediationDate: '2016-10-17',
        RemediationSteps: 'Used hair dryer'
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:remediate, [payload]).and_return(status: 200, body: {})
        subject.remediate([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:remediate, [payload]).and_return(status: 200, body: {})
        subject.remediate(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/packages/v1/remediate')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.remediate(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end

  describe '#adjust' do
    let(:payload) do
      {
        Label: 'ABCDEF012345670000020201',
        Quantity: 2.0,
        UnitOfMeasureName: 'Ounces',
        AdjustmentReason: 'Drying',
        AdjustmentDate: '2015-12-15',
        AdjustmentNote: nil
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:adjust, [payload]).and_return(status: 200, body: {})
        subject.adjust([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:adjust, [payload]).and_return(status: 200, body: {})
        subject.adjust(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/packages/v1/adjust')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.adjust(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end

  describe '#finish' do
    let(:payload) do
      {
        Label: 'ABCDEF012345670000020201',
        FinishedDate: '0001-01-01T00:00:00Z'
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:finish, [payload]).and_return(status: 200, body: {})
        subject.finish([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:finish, [payload]).and_return(status: 200, body: {})
        subject.finish(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/packages/v1/finish')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.finish(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end

  describe '#unfinish' do
    let(:payload) do
      {
        Label: 'ABCDEF012345670000020201'
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:unfinish, [payload]).and_return(status: 200, body: {})
        subject.unfinish([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:unfinish, [payload]).and_return(status: 200, body: {})
        subject.unfinish(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/packages/v1/unfinish')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.unfinish(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end
end
