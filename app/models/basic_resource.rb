class BasicResource < ApplicationRecord
  before_create :create_uuid
  has_and_belongs_to_many :capabilities

  def self.all_sensors
    BasicResource.where(capabilities: Capabilities.all_sensors)
  end

  def self.all_actuators
    BasicResource.where(capabilities: Capabilities.all_actuators)
  end

  private

    def create_uuid
      self.uuid = SecureRandom.uuid
    end
end
