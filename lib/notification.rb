require 'rest-client'

module SmartCities

  module Notification

    def notify_resource(resource, update = false)
      Thread.new do
        base_collector_url = SERVICES_CONFIG['services']['collector']
        base_actuator_url = SERVICES_CONFIG['services']['actuator']

        resource_path = "/resources/"
        resource_path += resource.uuid if update

        if resource.sensor?
          begin
            if update
              RestClient.put base_collector_url + resource_path, json_structure(resource).to_json, content_type: 'application/json'
            else
              RestClient.post base_collector_url + resource_path, json_structure(resource).to_json, content_type: 'application/json'
            end
          rescue Exception => e
            puts "="*80, "Could not notify Collector service on resource #{resource.id} creation/update - ERROR #{e}", "="*80
          end
        end

        if resource.actuator?
          begin
            if update
              RestClient.put base_actuator_url + resource_path, json_structure(resource, 'actuators').to_json, content_type: 'application/json'
            else
              RestClient.post base_actuator_url + resource_path, json_structure(resource, 'actuators').to_json, content_type: 'application/json'
            end
          rescue Exception => e
            puts "="*80, "Could not notify Actuator service on resource #{resource.id} creation/update - ERROR #{e}", "="*80
          end
        end
      end
    end

    def json_structure(resource, capabilities_function = nil)
      {
        data: resource.to_json(capabilities_function)
      }
    end

  end

end
