class BasicResource < ApplicationRecord
  before_create :create_uuid

  def self.all_sensors
    BasicResource.where(sensor: true)
  end

  def self.all_actuators
    BasicResource.where(actuator: true)
  end

  private

    def create_uuid
      self.uuid = SecureRandom.uuid
    end
end
