class Capability < ApplicationRecord

  has_and_belongs_to_many :basic_resources

  def self.all_sensors
    where(sensor: true)
  end

  def self.all_actuators
    where(sensor: false)
  end

end
