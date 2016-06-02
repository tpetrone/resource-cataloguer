class BasicResource < ApplicationRecord
  before_create :create_uuid
  has_and_belongs_to_many :capabilities

  def self.all_sensors
    joins(:capabilities).where("capabilities.sensor" => true)
  end

  def self.all_actuators
    joins(:capabilities).where("capabilities.sensor" => false)
  end

  def to_json
    hash = attributes.to_options
    hash[:capabilities] = []
    capabilities.each do |cap|
      hash[:capabilities] << cap.name + "_" + cap.kind
    end
    hash
  end

  private

    def create_uuid
      self.uuid = SecureRandom.uuid
    end
end
