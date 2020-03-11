require 'spec_helper'

describe NCS::Client do
  before(:each) { configure_client }
  let(:subject) { described_class.new(NCS.configuration.to_h) }

  it 'does not initialize without credentials' do
    NCS.configure do |config|
      config.api_key = nil
    end

    expect { NCS::Client.new }.to(raise_error(NCS::Errors::MissingConfiguration))
  end

  it 'creates a room' do
    stub_request(:post, 'https://api.ncsanalytics.com/pos/rooms/v1/create')
      .to_return(body: '{}', status: '204')

    subject.room_create({ name: "Room #{Time.now.getutc}" })
  end

  it 'gets rooms' do
    stub_request(:get, 'https://api.ncsanalytics.com/pos/rooms/v1/all')
      .to_return(body: '{}', status: '204')

    subject.room_get_all
  end

  it 'updates a room' do
    stub_request(:get, 'https://api.ncsanalytics.com/pos/rooms/v1/all')
      .to_return(body: '[ { "id": 1, "name": "Castle Black" } ]', status: '200')
    stub_request(:post, 'https://api.ncsanalytics.com/pos/rooms/v1/update')
      .to_return(body: '{}', status: '200')

    rooms = subject.room_get_all
    first_room = rooms[0]
    first_room['name'] = "First Room #{first_room['id']}"

    subject.room_update(first_room)

    first_room['name'] = 'First Room 187621'

    subject.room_update(first_room)
  end
end
