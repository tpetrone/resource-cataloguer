require 'rest-client'

module SmartCities

  module Notification
    def notify_resource_creation(resource)
      Thread.new do
        base_collector_url = SERVICES_CONFIG['services']['collector']
        base_actuator_url = SERVICES_CONFIG['services']['actuator']
        resource_path = "/resources"

        if resource.sensor?
          begin
            RestClient.post base_collector_url + resource_path, json_structure(resource).to_json, content_type: 'application/json'
          rescue Exception => e
            puts "="*80, "Could not notify Collector service on resource #{resource.id} creation - ERROR #{e}", "="*80
          end
        end

        if resource.actuator?
          begin
            RestClient.post base_actuator_url + resource_path, json_structure(resource).to_json, content_type: 'application/json'
          rescue Exception => e
            puts "="*80, "Could not notify Actuator service on resource #{resource.id} creation - ERROR #{e}", "="*80
          end
        end

      end
    end

    def notify_resource_update(resource)
      Thread.new do
        base_collector_url = SERVICES_CONFIG['services']['collector']
        base_actuator_url = SERVICES_CONFIG['services']['actuator']
        resource_path = "/resources/#{resource.uuid}"

        if resource.sensor?
          begin
            RestClient.put base_collector_url + resource_path, json_structure(resource).to_json, content_type: 'application/json'
          rescue Exception => e
            puts "="*80, "Could not notify Collector service on resource #{resource.id} update - ERROR #{e}", "="*80
          end
        end

        if resource.actuator?
          begin
            RestClient.put base_actuator_url + resource_path, json_structure(resource).to_json, content_type: 'application/json'
          rescue Exception => e
            puts "="*80, "Could not notify Actuator service on resource #{resource.id} update - ERROR #{e}", "="*80
          end
        end

      end
    end

    def json_structure(resource)
      {
        data: resource.to_json
      }
    end

  end

end
