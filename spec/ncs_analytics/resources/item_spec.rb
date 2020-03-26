require 'spec_helper'

describe NcsAnalytics::Resources::Item do
  subject { described_class.new }

  before { configure_client }

  it 'has a resource' do
    expect(subject.resource).to eq(:items)
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

  describe '#categories' do
    it 'does not raise an error' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:categories).and_return(status: 200, body: {})
      expect { subject.categories }.not_to raise_error
    end

    it 'calls the GET endpoint' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:categories).and_return(status: 200, body: {})
      subject.categories
    end
  end

  describe '#create' do
    let(:payload) do
      {
        ProductCategoryName: 'Buds',
        Name: 'Buds Item',
        UnitOfMeasureName: 'Ounces',
        AdministrationMethod: nil,
        StrainName: 'Spring Hill Kush',
        IntermediaryProductUsed: true,
        UnitCbdPercent: nil,
        UnitCbdContent: nil,
        UnitCbdContentUnitOfMeasureName: nil,
        UnitThcPercent: nil,
        UnitThcContent: nil,
        UnitThcContentUnitOfMeasureName: nil,
        UnitVolume: nil,
        UnitVolumeUnitOfMeasureName: nil,
        UnitWeight: nil,
        UnitWeightUnitOfMeasureName: nil,
        ServingSize: nil,
        SupplyDurationDays: nil,
        Ingredients: nil,
        Intermediaries: [
          {
            Id: 4,
            Name: 'Interm 1',
            Type: 'Mush'
          },
          {
            Name: 'Interm 2',
            Type: 'Tar'
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
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/items/v1/create')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.create(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end

  describe '#create_categories' do
    let(:payload) do
      {
        Name: 'Infused',
        ProductCategoryType: 'InfusedEdible',
        QuantityType: 'CountBased',
        DefaultLabTestingState: 'NotSubmitted',
        RequiresApproval: false,
        RequiresAdministrationMethod: false,
        RequiresStrain: true,
        RequiresUnitCbdPercent: false,
        RequiresUnitCbdContent: false,
        RequiresUnitThcPercent: false,
        RequiresUnitThcContent: false,
        RequiresUnitVolume: false,
        RequiresUnitWeight: false,
        RequiresServingSize: false,
        RequiresSupplyDurationDays: false,
        UnitQuantityMultiplier: nil,
        UnitQuantityUnitOfMeasureName: nil,
        RequiresIngredients: false,
        RequiresProductPhoto: false,
        CanContainSeeds: true,
        CanBeRemediated: true
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with('create/categories', [payload]).and_return(status: 200, body: {})
        subject.create_categories([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with('create/categories', [payload]).and_return(status: 200, body: {})
        subject.create_categories(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/items/v1/create/categories')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.create_categories(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end

  describe '#update' do
    let(:payload) do
      {
        ProductCategoryName: 'Buds',
        Name: 'Buds Item',
        UnitOfMeasureName: 'Ounces',
        AdministrationMethod: nil,
        StrainName: 'Spring Hill Kush',
        IntermediaryProductUsed: true,
        UnitCbdPercent: nil,
        UnitCbdContent: nil,
        UnitCbdContentUnitOfMeasureName: nil,
        UnitThcPercent: nil,
        UnitThcContent: nil,
        UnitThcContentUnitOfMeasureName: nil,
        UnitVolume: nil,
        UnitVolumeUnitOfMeasureName: nil,
        UnitWeight: nil,
        UnitWeightUnitOfMeasureName: nil,
        ServingSize: nil,
        SupplyDurationDays: nil,
        Ingredients: nil,
        Intermediaries: [
          {
            Id: 4,
            Name: 'Interm 1',
            Type: 'Mush'
          },
          {
            Name: 'Interm 2',
            Type: 'Tar'
          }
        ]
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
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/items/v1/update')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.update(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end

  describe '#update_categories' do
    let(:payload) do
      {
        Name: 'Infused',
        ProductCategoryType: 'InfusedEdible',
        QuantityType: 'CountBased',
        DefaultLabTestingState: 'NotSubmitted',
        RequiresApproval: false,
        RequiresAdministrationMethod: false,
        RequiresStrain: true,
        RequiresUnitCbdPercent: false,
        RequiresUnitCbdContent: false,
        RequiresUnitThcPercent: false,
        RequiresUnitThcContent: false,
        RequiresUnitVolume: false,
        RequiresUnitWeight: false,
        RequiresServingSize: false,
        RequiresSupplyDurationDays: false,
        UnitQuantityMultiplier: nil,
        UnitQuantityUnitOfMeasureName: nil,
        RequiresIngredients: false,
        RequiresProductPhoto: false,
        CanContainSeeds: true,
        CanBeRemediated: true
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with('update/categories', [payload]).and_return(status: 200, body: {})
        subject.update_categories([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with('update/categories', [payload]).and_return(status: 200, body: {})
        subject.update_categories(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/items/v1/update/categories')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.update_categories(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end
end
