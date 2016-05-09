class ApplicationController < ActionController::API

  # GET /resources/sensors
  def index_sensors
    @basic_resources = BasicResources.where(sensor: true)
    render json: @basic_resources
  end

  # GET /resources/actuators
  def index_actuators
    @basic_resources = BasicResources.where(actuator: true)
    render json: @basic_resources
  end

end
