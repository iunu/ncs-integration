require 'spec_helper'

describe NCS do
  before(:each) { configure_client }

  it 'has a version number' do
    expect(NCS::VERSION).not_to be nil
  end

  it 'accepts a configuration, requires a complete configuration' do
    NCS.configure do |config|
      config.api_key = nil
    end

    expect(NCS.configuration.incomplete?).to be_truthy
  end

  it 'does not initialize without credentials' do
    NCS.configure do |config|
      config.api_key = nil
    end

    expect { NCS::Client.new }.to(raise_error(NCS::Errors::MissingConfiguration))
  end

  it 'creates a room' do
    WebMock.allow_net_connect!
    #NCS::Client.new(NCS::configuration.to_h).room_create({'Name' => 'Room 523'})
    WebMock.disable_net_connect!
  end

  it 'gets rooms' do
    WebMock.allow_net_connect!
    #NCS::Client.new(NCS::configuration.to_h).room_get_all
    WebMock.disable_net_connect!
  end

  it 'updates a room' do
    WebMock.allow_net_connect!
    client=NCS::Client.new(NCS::configuration.to_h)
    rooms=client.room_get_all
    #puts rooms
    first_room=rooms[0]
    first_room["name"]="First Room "+first_room["id"].to_s
    client.room_update(first_room)
    #puts rooms
    first_room["name"]="First Room 187621"
    client.room_update(first_room)
    #puts client.room_get_all
    WebMock.disable_net_connect!
  end

end