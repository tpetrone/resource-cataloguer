require 'rails_helper'

RSpec.describe Capability, :type => :model do

  let!(:temperature_sensor) { Capability.create(name: "collect_temperature", function: Capability.sensor_index) }
  let!(:semaphore_actuator) { Capability.create(name: "manipulate_semaphore", function: Capability.actuator_index) }

  context 'sensor capability only' do
    describe '#create' do
      it "automatically define sensor flag based on name" do
        expect(temperature_sensor).to be_sensor
        expect(temperature_sensor).to_not be_actuator
      end
    end

    describe '#kind' do
      it 'returns the correct kind' do
        expect(temperature_sensor).to be_sensor
      end
    end
  end

  context 'actuator capability only' do
    describe '#create' do
      it "automatically define actuator flag based on name" do
        expect(semaphore_actuator).to_not be_sensor
        expect(semaphore_actuator).to be_actuator
      end
    end

    describe '#kind' do
      it 'returns the correct kind' do
        expect(semaphore_actuator).to be_actuator
      end
    end
  end

  context 'all kinds of capabilities' do
    let(:resource1) {
      BasicResource.create(
        description: "just a resource",
        lat: 10,
        lon: 10,
        status: "stopped",
        collect_interval: 5,
        uri: "example.com"
      )
    }

    let(:resource2) {
      BasicResource.create(
        description: "just another resource",
        lat: -10,
        lon: 10,
        status: "stopped",
        collect_interval: 10,
        uri: "another_example.com"
      )
    }

    before do
      resource1.capabilities << semaphore_actuator
      resource2.capabilities << semaphore_actuator
      resource1.capabilities << temperature_sensor
    end

    describe '#basic_resources' do
      it 'properly includes the correct resources' do
        expect(semaphore_actuator.basic_resources).to include(resource1)
        expect(semaphore_actuator.basic_resources).to include(resource2)
        expect(temperature_sensor.basic_resources).to include(resource1)
      end

      it 'does not include incorrect resources' do
        expect(temperature_sensor.basic_resources).to_not include(resource2)
      end
    end

  end

  describe '.all_sensors' do
    it 'includes temperature sensor' do
      expect(described_class.all_sensors).to include(temperature_sensor)
    end

    it 'does not include semaphore actuator' do
      expect(described_class.all_sensors).to_not include(semaphore_actuator)
    end
  end

  describe '.all_actuators' do
    it 'does not include temperature sensor' do
      expect(described_class.all_actuators).to_not include(temperature_sensor)
    end

    it 'include semaphore actuator' do
      expect(described_class.all_actuators).to include(semaphore_actuator)
    end
  end
end
