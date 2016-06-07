class BasicResource < ApplicationRecord
  before_create :create_uuid
  has_and_belongs_to_many :capabilities
  validates :description, presence: true
  validates :lat, presence: true, numericality: true
  validates :lon, presence: true, numericality: true
  validates :status, presence: true
  validates :collect_interval, presence: true, numericality: true
  validates :uri, presence: true, uniqueness: true

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
