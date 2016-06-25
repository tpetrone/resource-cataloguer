module SmartCities

  class Location

    def self.complete_postal_code(results)
      begin
        pc = results.first.postal_code
        if pc.length == 5
          results.each do |result|
            result_pc = result.postal_code
            if pc == result_pc[0,5] and result_pc.length == 9
              return pc << result_pc[5,4]
            end 
          end
          return pc << "-000"
        end
        pc
      rescue
        nil
      end
    end

    def self.get_neighborhood(address)
      neighborhood = nil 
      address.each do |component|
        if component["types"].include? "sublocality"
          neighborhood = component["long_name"]
          break
        end
      end
      neighborhood
    end
  
  end

end
