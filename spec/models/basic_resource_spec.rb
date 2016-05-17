require 'rails_helper'

RSpec.describe BasicResource, :type => :model do

  describe '#create' do
    let(:resource) { described_class.create! }
    it "automatically creates an uuid" do
      expect(resource.uuid).to_not be_nil
    end

    it "has sensor and actuator flag as false by default" do
      expect(resource.sensor?).to be false
      expect(resource.actuator?).to be false
    end
  end
  
  describe '.all_sensors' do

    context 'there are no sensors' do
      subject { described_class.all_sensors }
      it { is_expected.to be_empty }
    end

    context 'there is one sensor and one actuator' do
      let!(:sensor) { described_class.create(sensor: true, actuator: false) }
      let!(:actuator) { described_class.create(sensor: false, actuator: true) }
      subject { described_class.all_sensors }
      it { is_expected.to include(sensor) }
      it { is_expected.not_to include(actuator) }
    end

    context 'there is a hybrid sensor-actuator' do
      let!(:hybrid) { described_class.create(sensor: true, actuator: true) }
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
      let!(:sensor) { described_class.create(sensor: true, actuator: false) }
      let!(:actuator) { described_class.create(sensor: false, actuator: true) }
      subject { described_class.all_actuators }
      it { is_expected.to include(actuator) }
      it { is_expected.not_to include(sensor) }
    end

    context 'there is a hybrid sensor-actuator' do
      let!(:hybrid) { described_class.create(sensor: true, actuator: true) }
      subject { described_class.all_actuators }
      it { is_expected.to include(hybrid) }
    end

  end

end
