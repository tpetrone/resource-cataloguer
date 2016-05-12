class BasicResourcesController < ApplicationController

  # POST /resources
  def index
    resource = BasicResource.new
    resource.save
    render json: resource, status: 201
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

end
