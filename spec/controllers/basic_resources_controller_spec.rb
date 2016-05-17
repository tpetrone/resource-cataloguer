require 'rails_helper'

RSpec.describe BasicResourcesController, :type => :controller do
  let(:json) {JSON.parse(response.body)}
  describe '#create' do

    before :each do
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

    let!(:resource) { BasicResource.create(sensor: true, actuator: true, uri: "qwedsa.com", lat: 20, lon: 20, status: "stopped", collect_interval: 5, description: "I am a dummy sensor") }

    before :each do
      get :show, params: {id: 1}, format: :json
    end

    it { expect(response.status).to eq(200) }

    it 'is expected to return the resource in JSON' do
      expect(response.body).to include('"uri":"qwedsa.com"')
      expect(response.body).to include('"sensor":true')
      expect(response.body).to include('"actuator":true')
      expect(response.body).to include('"lat":20')
      expect(response.body).to include('"lon":20')
      expect(response.body).to include('"status":"stopped"')
      expect(response.body).to include('"collect_interval":5')
      expect(response.body).to include('"description":"I am a dummy sensor"')
    end

  end

  describe '#update' do

    let!(:resource) { BasicResource.create(sensor: true,
                                           actuator: true,
                                           lat: 20,
                                           lon: 20,
                                           status: "stopped",
                                           collect_interval: 5,
                                           description: "I am a dummy sensor",
                                           uri: "qwedsa.com") }

    before :each do
      put :update, params: {id: resource.id, sensor: false, uri: "changed.com", actuator: true}, format: :json
    end

    it { expect(response.status).to eq(204) }
    it 'is expected to update resource data' do
      updated_resource = BasicResource.find(resource.id)
      expect(updated_resource.uri).to eq('changed.com')
      expect(updated_resource.sensor).to eq(false)
      expect(updated_resource.actuator).to eq(true)
      expect(updated_resource.lat).to eq(20)
      expect(updated_resource.lon).to eq(20)
      expect(updated_resource.status).to eq("stopped")
      expect(updated_resource.collect_interval).to eq(5)
      expect(updated_resource.description).to eq("I am a dummy sensor")
    end
  end

end
