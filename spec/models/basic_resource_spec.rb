require 'rails_helper'

RSpec.describe BasicResource, :type => :model do

  let!(:temperature_sensor) { Capability.create(name: "temperature", sensor: true) }
  let!(:semaphore_actuator) { Capability.create(name: "semaphore", sensor: false) }
  let(:resource_params) {{
    description: "just a resource",
    lat: 10,
    lon: 10,
    status: "stopped",
    collect_interval: 5,
    uri: "example.com"
  }}

  describe '#create' do
    let(:resource) { described_class.create(resource_params) }
    it "automatically creates an uuid" do
      expect(resource.uuid).to_not be_nil
    end
  end

  describe '.all_sensors' do

    context 'there are no sensors' do
      subject { described_class.all_sensors }
      it { is_expected.to be_empty }
    end

    context 'there is one sensor and one actuator' do
      let!(:sensor) { described_class.create(resource_params.merge(capabilities: [temperature_sensor], uri: "example1.com")) }
      let!(:actuator) { described_class.create(resource_params.merge(capabilities: [semaphore_actuator], uri: "example2.com")) }
      subject { described_class.all_sensors }
      it { is_expected.to include(sensor) }
      it { is_expected.not_to include(actuator) }
    end

    context 'there is a hybrid sensor-actuator' do
      let!(:hybrid) { described_class.create(resource_params.merge(capabilities: [temperature_sensor, semaphore_actuator])) }
      subject { described_class.all_sensors }
      it { is_expected.to include(hybrid) }
    end

  end

  describe '.all_actuators' do

    context 'there are no actuators' do
      subject { described_class.all_actuators }
      it { is_expected.to be_empty }
    end

    context 'there is one sensor and one actuator' do
      let!(:sensor) { described_class.create(resource_params.merge(capabilities: [temperature_sensor], uri: "example1.com")) }
      let!(:actuator) { described_class.create(resource_params.merge(capabilities: [semaphore_actuator], uri: "example2.com")) }
      subject { described_class.all_actuators }
      it { is_expected.to include(actuator) }
      it { is_expected.not_to include(sensor) }
    end

    context 'there is a hybrid sensor-actuator' do
      let!(:hybrid) { described_class.create(resource_params.merge(capabilities: [temperature_sensor, semaphore_actuator])) }
      subject { described_class.all_actuators }
      it { is_expected.to include(hybrid) }
    end

  end

  describe '#sensor?' do
    let!(:actuator) { described_class.create(resource_params.merge(capabilities: [semaphore_actuator], uri: "example2.com")) }
    let!(:sensor) { described_class.create(resource_params.merge(capabilities: [temperature_sensor], uri: "example1.com")) }
    context 'resource is a sensor' do
      subject { sensor.sensor? }
      it { is_expected.to eq(true) }
    end

    context 'resource is an actuator' do
      subject { actuator.actuator? }
      it { is_expected.to eq(true) }
    end

  end

end
