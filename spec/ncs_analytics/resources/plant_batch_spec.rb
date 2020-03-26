require 'spec_helper'

describe NcsAnalytics::Resources::PlantBatch do
  subject { described_class.new }

  before { configure_client }

  it 'has a resource', only: true do
    expect(subject.resource).to eq(:plantbatches)
  end

  describe '#find' do
    context 'with no ID' do
      it 'raises a BadRequest error' do
        expect { subject.find }.to raise_error NcsAnalytics::Errors::BadRequest
      end
    end

    context 'with an ID' do
      it 'does not raise an error' do
        expect_any_instance_of(described_class).to receive(:get).at_least(:once).with('plantid/1').and_return(status: 200, body: {})
        expect { subject.find(1) }.not_to raise_error
      end

      it 'calls the GET endpoint' do
        expect_any_instance_of(described_class).to receive(:get).at_least(:once).with('plantid/1').and_return(status: 200, body: {})
        subject.find(1)
      end
    end
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

  describe '#create' do
    let(:payload) do
      {
        Name: 'Test Plant Batch 1',
        Type: 'Clone',
        Count: 30,
        StrainName: 'Spring Hill Kush',
        RoomName: nil,
        PlantedDate: '2015-12-15'
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:createplantings, [payload]).and_return(status: 200, body: {})
        subject.create([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:createplantings, [payload]).and_return(status: 200, body: {})
        subject.create(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/plantbatches/v1/createplantings')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.create(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end

  describe '#create_packages' do
    let(:payload) do
      {
        PlantBatchId: nil,
        PlantBatchName: 'Demo Plant Batch 1',
        PlantCount: 10,
        RoomName: nil,
        ProductName: 'Immature Plants',
        Label: 'ABCDEF01234567000002020',
        PackagedDate: '2015-12-15'
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:createpackages, [payload]).and_return(status: 200, body: {})
        subject.create_packages([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:createpackages, [payload]).and_return(status: 200, body: {})
        subject.create_packages(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/plantbatches/v1/createpackages')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.create_packages(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end

  describe '#destroy' do
    let(:payload) do
      {
        Name: 'Test Plant Batch 1',
        DestroyedCount: 25,
        DestroyedNote: 'Why must we all die .. You will die and like it too, bye bye plants!',
        DestroyedDate: '2018-06-14'
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:destroy, [payload]).and_return(status: 200, body: {})
        subject.destroy([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:destroy, [payload]).and_return(status: 200, body: {})
        subject.destroy(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/plantbatches/v1/destroy')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.destroy(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end

  describe '#change_growth_phase' do
    let(:payload) do
      {
        Name: 'Test Plant Batch 1',
        Count: 25,
        NewTag: 'ABCDEF012345670000020401',
        GrowthPhase: 'Flowering',
        RoomName: 'Plants Room',
        GrowthDate: '2015-12-15'
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:changegrowthphase, [payload]).and_return(status: 200, body: {})
        subject.change_growth_phase([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:changegrowthphase, [payload]).and_return(status: 200, body: {})
        subject.change_growth_phase(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/plantbatches/v1/changegrowthphase')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.change_growth_phase(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end
end
