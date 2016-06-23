module SmartCities

  module Location

    def complete_postal_code(results)
      begin
        pc = results.first.postal_code
        if pc.length == 5
          results.each do |result|
            result_pc = result.postal_code
            if pc == result_pc[0,5] and result_pc.length == 9
              pc << result_pc[5,4]
              break
            end 
          end
        end
        pc
      rescue
        nil
      end
    end

    def get_neighborhood(address)
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
