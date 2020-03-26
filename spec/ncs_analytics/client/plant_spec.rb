require 'spec_helper'

describe NcsAnalytics::Plant do
  subject { described_class.new }

  before { configure_client }

  it 'has a resource' do
    expect(subject.resource).to eq(:plants)
  end

  describe '#all' do
    it 'does not raise an error' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:all).and_return(status: 200, body: {})
      expect { subject.all }.not_to raise_error
    end

    it 'calls the GET endpoint' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:all).and_return(status: 200, body: {})
      subject.all
    end
  end

  describe '#find' do
    context 'with no ID' do
      it 'raises a BadRequest error' do
        expect { subject.find }.to raise_error NcsAnalytics::Errors::BadRequest
      end
    end

    context 'with an ID' do
      it 'does not raise an error' do
        expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(1).and_return(status: 200, body: {})
        expect { subject.find(1) }.not_to raise_error
      end

      it 'calls the GET endpoint' do
        expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(1).and_return(status: 200, body: {})
        subject.find(1)
      end
    end
  end

  describe '#vegetative' do
    it 'does not raise an error' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:vegetative).and_return(status: 200, body: {})
      expect { subject.vegetative }.not_to raise_error
    end

    it 'calls the GET endpoint' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:vegetative).and_return(status: 200, body: {})
      subject.vegetative
    end
  end

  describe '#flowering' do
    it 'does not raise an error' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:flowering).and_return(status: 200, body: {})
      expect { subject.flowering }.not_to raise_error
    end

    it 'calls the GET endpoint' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:flowering).and_return(status: 200, body: {})
      subject.flowering
    end
  end

  describe '#create' do
    let(:payload) do
      {
        Label: 'ABCDEF012345670000010011',
        PlantBatchName: 'Demo Plant Batch 1',
        PlantBatchTypeName: 'Clone',
        PlantCount: 2,
        RoomName: nil,
        StrainName: 'Spring Hill Kush',
        PlantedDate: '2016-10-18T13:11:03Z'
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with('create/plantings', [payload]).and_return(status: 200, body: {})
        subject.create([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with('create/plantings', [payload]).and_return(status: 200, body: {})
        subject.create(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/plants/v1/create/plantings')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.create(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end

  describe '#destroy' do
    let(:payload) do
      {
        Id: 54,
        Label: nil,
        DestroyedNote: '',
        DestroyedDate: '2015-12-15'
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:destroyplants, [payload]).and_return(status: 200, body: {})
        subject.destroy([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:destroyplants, [payload]).and_return(status: 200, body: {})
        subject.destroy(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/plants/v1/destroyplants')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.destroy(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end

  describe '#change_growth_phases' do
    let(:payload) do
      {
        Id: nil,
        Label: 'ABCDEF012345670000010011',
        NewTag: 'ABCDEF012345670000020001',
        GrowthPhase: 'Flowering',
        NewRoom: 'Plants Room',
        GrowthDate: '2015-12-15'
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:changegrowthphases, [payload]).and_return(status: 200, body: {})
        subject.change_growth_phases([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:changegrowthphases, [payload]).and_return(status: 200, body: {})
        subject.change_growth_phases(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/plants/v1/changegrowthphases')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.change_growth_phases(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end

  describe '#move' do
    let(:payload) do
      {
        Id: nil,
        Label: 'ABCDEF012345670000010011',
        RoomName: 'Harvest Room'
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:moveplants, [payload]).and_return(status: 200, body: {})
        subject.move([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:moveplants, [payload]).and_return(status: 200, body: {})
        subject.move(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/plants/v1/moveplants')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.move(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end

  describe '#manicure' do
    let(:payload) do
      {
        Label: 'ABCDEF012345670000020001',
        ManicuredWeight: 100.23,
        ManicuredUnitOfWeightName: 'Grams',
        RoomName: 'Plants Room',
        HarvestName: nil,
        ManicuredDate: '2015-12-15'
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:manicureplants, [payload]).and_return(status: 200, body: {})
        subject.manicure([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:manicureplants, [payload]).and_return(status: 200, body: {})
        subject.manicure(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/plants/v1/manicureplants')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.manicure(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end

  describe '#harvest' do
    let(:payload) do
      {
        Label: 'ABCDEF012345670000020001',
        HarvestedWetWeight: 100.23,
        HarvestedUnitOfWeightName: 'Grams',
        RoomName: 'Harvest Room',
        HarvestName: '2015-12-15-Harvest Room-H',
        HarvestedDate: '2015-12-15'
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:harvestplants, [payload]).and_return(status: 200, body: {})
        subject.harvest([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:harvestplants, [payload]).and_return(status: 200, body: {})
        subject.harvest(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/plants/v1/harvestplants')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.harvest(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end
end
