require 'rails_helper'
require 'spec_helper'

describe BasicResourcesController do
  let(:temperature_sensor) { Capability.create(name: "temperature", sensor: true) }
  let(:json) {JSON.parse(response.body)}
  describe '#create' do
    before :each do
      BasicResource.destroy_all
      post 'create',
        params: {
          data: {
            uri: "example.com",
            lat: 20,
            lon: 20,
            status: "stopped",
            collect_interval: 5,
            description: "I am a dummy sensor"
          }
        },
      format: :json
    end

    it { expect(response.status).to eq(201) }
    it 'is expected to return the location of the new resource in the header' do
      expect(response.location).to match(/resources\/\d+/)
    end
    it 'is expected to return the resource in JSON' do
      expect(json["data"]["id"].class).to eq(Fixnum)
      expect(json["data"]["uri"]).to eq("example.com")
      expect(json["data"]["lat"]).to eq(20)
      expect(json["data"]["lon"]).to eq(20)
      expect(json["data"]["status"]).to eq('stopped')
      expect(json["data"]["collect_interval"]).to eq(5)
      expect(json["data"]["description"]).to eq("I am a dummy sensor")
    end

    it 'is expected to create a resource' do
      expect(BasicResource.count).to be(1)
    end

    it 'generates a uuid to the new resource' do
      resource = BasicResource.last
      expect(resource.uuid).to_not be_nil
    end
  end

  describe '#index_sensors' do

    before :each do
      get 'index_sensors', format: :json
    end

    it { expect(response.status).to eq(200) }

    it 'is expected to return an empty JSON list' do
      expect(response.body).to eq("[]")
    end

  end

  describe '#index_actuators' do

    before :each do
      get 'index_actuators', format: :json
    end

    it { expect(response.status).to eq(200) }

    it 'is expected to return an empty JSON list' do
      expect(response.body).to eq("[]")
    end

  end

  describe '#show' do

    let!(:resource) { BasicResource.create(uri: "qwedsa.com",
                                           lat: 20,
                                           lon: 20,
                                           status: "stopped",
                                           collect_interval: 5,
                                           description: "I am a dummy sensor",
                                           capabilities: [temperature_sensor])}

    before :each do
      get :show, params: {uuid: resource.uuid}, format: :json
    end

    it { expect(response.status).to eq(200) }

    it 'is expected to return the resource in JSON' do
      expect(json['data']['uri']).to eq(resource.uri)
      expect(json['data']['uuid']).to eq(resource.uuid)
      expect(json['data']['lat']).to eq(resource.lat)
      expect(json['data']['lon']).to eq(resource.lon)
      expect(json['data']['status']).to eq(resource.status)
      expect(json['data']['collect_interval']).to eq(resource.collect_interval)
      expect(json['data']['description']).to eq(resource.description)
      expect(json['data']['capabilities']).to eq(['temperature_sensor'])
    end

  end

  describe '#update' do

    let!(:resource) { BasicResource.create(lat: 20,
                                           lon: 20,
                                           status: "stopped",
                                           collect_interval: 5,
                                           description: "I am a dummy sensor",
                                           uri: "qwedsa.com",
                                           capabilities: [temperature_sensor])}

    before :each do
      allow(controller).to receive(:notify_resource_update).and_return(true)
      put :update, params: {uuid: resource.uuid, data: {uri: "changed.com", lat: -40, lon: -40, collect_interval: 1}}, format: :json
    end

    it { expect(response.status).to eq(204) }
    it 'is expected to update resource data' do
      updated_resource = BasicResource.find(resource.id)
      expect(updated_resource.uri).to eq('changed.com')
      expect(updated_resource.lat).to eq(-40)
      expect(updated_resource.lon).to eq(-40)
      expect(updated_resource.status).to eq("stopped")
      expect(updated_resource.collect_interval).to eq(1)
      expect(updated_resource.description).to eq("I am a dummy sensor")
    end
  end

end
