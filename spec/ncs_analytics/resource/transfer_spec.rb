require 'spec_helper'

describe NcsAnalytics::Transfer do
  subject { described_class.new }

  before { configure_client }

  it 'has a resource' do
    expect(subject.resource).to eq(:transfers)
  end

  describe '#all_incoming' do
    it 'does not raise an error' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:incoming).and_return(status: 200, body: {})
      expect { subject.all_incoming }.not_to raise_error
    end

    it 'calls the GET endpoint' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:incoming).and_return(status: 200, body: {})
      subject.all_incoming
    end
  end

  describe '#all_outgoing' do
    it 'does not raise an error' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:outgoing).and_return(status: 200, body: {})
      expect { subject.all_outgoing }.not_to raise_error
    end

    it 'calls the GET endpoint' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:outgoing).and_return(status: 200, body: {})
      subject.all_outgoing
    end
  end

  describe '#all_rejected' do
    it 'does not raise an error' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:rejected).and_return(status: 200, body: {})
      expect { subject.all_rejected }.not_to raise_error
    end

    it 'calls the GET endpoint' do
      expect_any_instance_of(described_class).to receive(:get).at_least(:once).with(:rejected).and_return(status: 200, body: {})
      subject.all_rejected
    end
  end

  describe '#create_incoming' do
    let(:payload) do
      {
        ManifestNumber: '0000000001',
        ShipperFacilityLicenseNumber: '123-ABC',
        ShipperFacilityName: 'Lofty Med-Cultivation B',
        Name: nil,
        TransporterFacilityLicenseNumber: '123-ABC',
        TransporterFacilityName: 'Lofty Med-Dispensary',
        DriverName: 'X',
        DriverOccupationalLicenseNumber: '',
        DriverVehicleLicenseNumber: '',
        VehicleMake: 'X',
        VehicleModel: 'X',
        VehicleLicensePlateNumber: 'X',
        DeliveryCount: 0,
        ReceivedDeliveryCount: 0,
        PackageCount: 7,
        ReceivedPackageCount: 0,
        CreatedDateTime: '2016-10-10T08:20:45-07:00',
        CreatedByUserName: nil,
        LastModified: '0001-01-01T00:00:00+00:00',
        DeliveryId: 1,
        RecipientFacilityLicenseNumber: '123-ABC',
        RecipientFacilityName: 'Lofty Med-Cultivation A',
        ShipmentTypeName: 'Transfer',
        ShipmentTransactionType: 'Standard',
        EstimatedDepartureDateTime: '2016-10-11T14:48:30.000',
        ActualDepartureDateTime: nil,
        EstimatedArrivalDateTime: '2016-10-11T16:50:00.000',
        ActualArrivalDateTime: nil,
        DeliveryPackageCount: 7,
        DeliveryReceivedPackageCount: 0,
        ReceivedDateTime: '2016-10-11T16:42:19-07:00',
        Packages: [
          {
            Label: 'ABCDEF012345670000010026'
          },
          {
            Label: 'ABCDEF012345670000010027'
          }
        ]
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:incoming, [payload]).and_return(status: 200, body: {})
        subject.create_incoming([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:incoming, [payload]).and_return(status: 200, body: {})
        subject.create_incoming(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/transfers/v1/incoming')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.create_incoming(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end

  describe '#create_outgoing' do
    let(:payload) do
      {
        ManifestNumber: '0000000001',
        ShipperFacilityLicenseNumber: '123-ABC',
        ShipperFacilityName: 'Lofty Med-Cultivation B',
        Name: nil,
        TransporterFacilityLicenseNumber: '123-ABC',
        TransporterFacilityName: 'Lofty Med-Dispensary',
        DriverName: 'X',
        DriverOccupationalLicenseNumber: '',
        DriverVehicleLicenseNumber: '',
        VehicleMake: 'X',
        VehicleModel: 'X',
        VehicleLicensePlateNumber: 'X',
        DeliveryCount: 0,
        ReceivedDeliveryCount: 0,
        PackageCount: 7,
        ReceivedPackageCount: 0,
        CreatedDateTime: '2016-10-10T08:20:45-07:00',
        CreatedByUserName: nil,
        LastModified: '0001-01-01T00:00:00+00:00',
        DeliveryId: 1,
        RecipientFacilityLicenseNumber: '123-ABC',
        RecipientFacilityName: 'Lofty Med-Cultivation A',
        ShipmentTypeName: 'Transfer',
        ShipmentTransactionType: 'Standard',
        EstimatedDepartureDateTime: '2016-10-11T14:48:30.000',
        ActualDepartureDateTime: nil,
        EstimatedArrivalDateTime: '2016-10-11T16:50:00.000',
        ActualArrivalDateTime: nil,
        DeliveryPackageCount: 7,
        DeliveryReceivedPackageCount: 0,
        ReceivedDateTime: '2016-10-11T16:42:19-07:00',
        Packages: [
          {
            Label: 'ABCDEF012345670000010026'
          },
          {
            Label: 'ABCDEF012345670000010027'
          }
        ]
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:outgoing, [payload]).and_return(status: 200, body: {})
        subject.create_outgoing([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:outgoing, [payload]).and_return(status: 200, body: {})
        subject.create_outgoing(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/transfers/v1/outgoing')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.create_outgoing(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end

  describe '#create_rejected' do
    let(:payload) do
      {
        ManifestNumber: '0000000001',
        ShipperFacilityLicenseNumber: '123-ABC',
        ShipperFacilityName: 'Lofty Med-Cultivation B',
        Name: nil,
        TransporterFacilityLicenseNumber: '123-ABC',
        TransporterFacilityName: 'Lofty Med-Dispensary',
        DriverName: 'X',
        DriverOccupationalLicenseNumber: '',
        DriverVehicleLicenseNumber: '',
        VehicleMake: 'X',
        VehicleModel: 'X',
        VehicleLicensePlateNumber: 'X',
        DeliveryCount: 0,
        ReceivedDeliveryCount: 0,
        PackageCount: 7,
        ReceivedPackageCount: 0,
        CreatedDateTime: '2016-10-10T08:20:45-07:00',
        CreatedByUserName: nil,
        LastModified: '0001-01-01T00:00:00+00:00',
        DeliveryId: 1,
        RecipientFacilityLicenseNumber: '123-ABC',
        RecipientFacilityName: 'Lofty Med-Cultivation A',
        ShipmentTypeName: 'Transfer',
        ShipmentTransactionType: 'Standard',
        EstimatedDepartureDateTime: '2016-10-11T14:48:30.000',
        ActualDepartureDateTime: nil,
        EstimatedArrivalDateTime: '2016-10-11T16:50:00.000',
        ActualArrivalDateTime: nil,
        DeliveryPackageCount: 7,
        DeliveryReceivedPackageCount: 0,
        ReceivedDateTime: '2016-10-11T16:42:19-07:00',
        Packages: [
          {
            Label: 'ABCDEF012345670000010026'
          },
          {
            Label: 'ABCDEF012345670000010027'
          }
        ]
      }
    end

    context 'with an array payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:rejected, [payload]).and_return(status: 200, body: {})
        subject.create_rejected([payload])
      end
    end

    context 'with a hash payload' do
      it 'sends the complete payload' do
        expect_any_instance_of(described_class).to receive(:post).at_least(:once).with(:rejected, [payload]).and_return(status: 200, body: {})
        subject.create_rejected(payload)
      end
    end

    context 'with a failed request' do
      before do
        stub_request(:post, 'https://vendortest-posapi.ncsanalytics.com/pos/transfers/v1/rejected')
          .with(headers: { 'Content-Type': 'application/json' })
          .to_return(status: 500, body: '{}')
      end

      it 'raises the exceeption' do
        expect { subject.create_rejected(payload) }.to raise_error(NcsAnalytics::Errors::InternalServerError)
      end
    end
  end
end
