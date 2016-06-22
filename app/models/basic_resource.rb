class BasicResource < ApplicationRecord
  before_create :create_uuid
  has_and_belongs_to_many :capabilities
  validates :lat, presence: true, numericality: true
  validates :lon, presence: true, numericality: true
  validates :status, presence: true
  validates :collect_interval, presence: true, numericality: true
  validates :uri, presence: true, uniqueness: true

  def self.all_sensors
    joins(:capabilities).where("capabilities.function" => Capability.sensor_index)
  end

  def self.all_actuators
    joins(:capabilities).where("capabilities.function" => Capability.actuator_index)
  end

  def self.all_informations
    joins(:capabilities).where("capabilities.function" => Capability.information_index)
  end

  def sensor?
    self.capabilities.where(function: Capability.sensor_index).count > 0
  end

  def actuator?
    self.capabilities.where(function: Capability.actuator_index).count > 0
  end

  def to_json
    hash = attributes.to_options
    hash[:capabilities] = []
    capabilities.each do |cap|
      hash[:capabilities] << cap.name + "_" + cap.function_symbol.to_s
    end
    hash
  end

  private

    def create_uuid
      self.uuid = SecureRandom.uuid
    end
end
