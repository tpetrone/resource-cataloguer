class BasicResourcesController < ApplicationController

  # POST /resources
  def create
    resource = BasicResource.new
    resource.save
    render json: resource, status: 201, location: basic_resource_url(resource)
  end

  # GET /resources/sensors
  def index_sensors
    render json: BasicResource.all_sensors
  end

  # GET /resources/actuators
  def index_actuators
    render json: BasicResource.all_actuators
  end

  # GET /resources/:id
  def show
    render json: BasicResource.find(params[:id])
  end

  # PUT /resources/:id
  def update
    resource = BasicResource.find(params[:id])
    resource.update(uri: params[:uri] || resource.uri,
                    sensor: params[:sensor] || resource.sensor,
                    actuator: params[:actuator] || resource.actuator)
  end

end
