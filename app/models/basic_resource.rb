class BasicResource < ApplicationRecord

  def self.all_sensors
    BasicResource.where(sensor: true)
  end

  def self.all_actuators
    BasicResource.where(actuator: true)
  end

end
