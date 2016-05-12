class BasicResourcesController < ApplicationController

  # POST /resources
  def create
    resource = BasicResource.new(uri: params[:uri],
                    lat: params[:lat],
                    long: params[:long],
                    status: params[:status],
                    collect_interval: params[:collect_interval],
                    description: params[:description],
                    sensor: params[:sensor],
                    actuator: params[:actuator])
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
                    lat: params[:lat] || resource.lat,
                    long: params[:long] || resource.long,
                    status: params[:status] || resource.status,
                    collect_interval: params[:collect_interval] || resource.collect_interval,
                    description: params[:description] || resource.description,
                    sensor: params[:sensor] || resource.sensor,
                    actuator: params[:actuator] || resource.actuator)
  end
end
