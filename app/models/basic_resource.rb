require 'geocoder'
require 'location'

class BasicResource < ApplicationRecord
  include SmartCities::Location

  before_create :create_uuid
  has_and_belongs_to_many :capabilities
  validates :description, presence: true
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

  reverse_geocoded_by :lat, :lon do |obj, results|
    if geo = results.first
      unless geo.postal_code.nil?
        obj.postal_code = obj.complete_postal_code(results)
      end
      obj.neighborhood = obj.get_neighborhood(geo.address_components)
      obj.city         = geo.city
      obj.state        = geo.state
      obj.country      = geo.country
    end
  end

  after_validation :reverse_geocode

  private

    def create_uuid
      self.uuid = SecureRandom.uuid
    end
end
