require 'rails_helper'

RSpec.describe BasicResourcesController, :type => :controller do

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

    let!(:resource) { BasicResource.create(sensor: true, actuator: true, uri: "qwedsa.com") }

    before :each do
      get :show, params: {id: 1}, format: :json
    end

    it { expect(response.status).to eq(200) }

    it 'is expected to return the resource in JSON' do
      expect(response.body).to include('"uri":"qwedsa.com"')
      expect(response.body).to include('"sensor":true')
      expect(response.body).to include('"actuator":true')
    end

  end

end
