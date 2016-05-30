require 'notification'

class BasicResourcesController < ApplicationController
  include SmartCities::Notification

  # POST /resources
  def create
    resource = BasicResource.new(component_params)
    resource.sensor = true
    resource.save!
    render json: {data: resource}, status: 201, location: basic_resource_url(resource)
  end

  # GET /resources/sensors
  def index_sensors
    render json: BasicResource.all_sensors
  end

  # GET /resources/actuators
  def index_actuators
    render json: BasicResource.all_actuators
  end

  # GET /resources/:uuid
  def show
    render json: {data: BasicResource.find_by_uuid(params[:uuid])}
  end

  # PUT /resources/:uuid
  def update
    resource = BasicResource.find_by_uuid(params[:uuid])
    resource.update(component_params)
    notify_resource_update(resource)
  end

  private

    def component_params
      params.require(:data).permit(:description, :lat, :lon, :status, :collect_interval, :capabilities, :uri)
    end
end
