require 'spec_helper'

describe NcsAnalytics::Harvest do
  subject { described_class.new }

  before { configure_client }

  it 'has a resource' do
    expect(subject.resource).to eq(:harvests)
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
        Name: 'Harvest Room-1',
        HarvestType: 'Product',
        DryingRoomId: 1,
        DryingRoomName: 'Harvest Room',
        UnitOfWeightName: 'Ounces',
        IsOnHold: false,
        HarvestStartDate: '2014-11-19',
        FinishedDate: nil,
        ArchivedDate: nil,
        LastModified: nil
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
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/harvests/v1/create')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.create(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end

  describe '#create_package' do
    let(:payload) do
      {
        HarvestId: 2,
        Label: 'ABCDEFGHIJK77646645333',
        RoomName: nil,
        ProductName: 'Buds',
        Weight: 5,
        UnitOfMeasureName: 'Grams',
        IsProductionBatch: true,
        ProductionBatchNumber: nil,
        ProductRequiresRemediation: true,
        RemediationMethodId: nil,
        RemediationDate: '2018-06-05',
        RemediationSteps: nil,
        PackagedDate: '2018-05-15'
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:createpackages, [payload]).and_return(status: 200, body: {})
        subject.create_package([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:createpackages, [payload]).and_return(status: 200, body: {})
        subject.create_package(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/harvests/v1/createpackages')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.create_package(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end

  describe '#update' do
    let(:payload) do
      {
        Name: 'Harvest Room-1',
        HarvestType: 'Product',
        DryingRoomId: 1,
        DryingRoomName: 'Harvest Room',
        UnitOfWeightName: 'Ounces',
        IsOnHold: false,
        HarvestStartDate: '2014-11-19',
        FinishedDate: nil,
        ArchivedDate: nil,
        LastModified: nil
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:update, [payload]).and_return(status: 200, body: {})
        subject.update([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:update, [payload]).and_return(status: 200, body: {})
        subject.update(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/harvests/v1/update')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.update(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end

  describe '#finish' do
    let(:payload) do
      {
        Id: 1,
        FinishedDate: '2018-03-15'
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
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/harvests/v1/finish')
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
        Id: 1
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
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/harvests/v1/unfinish')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.unfinish(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end

  describe '#remove_waste' do
    let(:payload) do
      {
        Id: 1,
        UnitOfWeightName: 'Grams',
        TotalWasteWeight: 15.85,
        FinishedDate: '2018-01-17'
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:removewaste, [payload]).and_return(status: 200, body: {})
        subject.remove_waste([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:removewaste, [payload]).and_return(status: 200, body: {})
        subject.remove_waste(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/harvests/v1/removewaste')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.remove_waste(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end
end
