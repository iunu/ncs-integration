require 'spec_helper'

describe CCA do
  before(:each) { configure_client }

  it 'has a version number' do
    expect(CCA::VERSION).not_to be nil
  end

  it 'accepts a configuration, requires a complete configuration' do
    CCA.configure do |config|
      config.api_key = nil
    end

    expect(CCA.configuration.incomplete?).to be_truthy
  end

  it 'does not initialize without credentials' do
    CCA.configure do |config|
      config.api_key = nil
    end

    expect { CCA::Client.new }.to(raise_error(CCA::Errors::MissingConfiguration))
  end

  it 'creates a room' do
    WebMock.allow_net_connect!
    #CCA::Client.new(CCA::configuration.to_h).room_create({'Name' => 'Room 523'})
    WebMock.disable_net_connect!
  end

  it 'gets rooms' do
    WebMock.allow_net_connect!
    #CCA::Client.new(CCA::configuration.to_h).room_get_all
    WebMock.disable_net_connect!
  end

  it 'updates a room' do
    WebMock.allow_net_connect!
    client=CCA::Client.new(CCA::configuration.to_h)
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