class BasicResourcesController < ApplicationController

  # GET /resources/sensors
  def index_sensors
    @basic_resources = BasicResource.where(sensor: true)
    render json: @basic_resources
  end

  # GET /resources/actuators
  def index_actuators
    @basic_resources = BasicResource.where(actuator: true)
    render json: @basic_resources
  end

end
