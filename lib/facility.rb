class Facility
  attr_reader :name, :address, :phone, :services, :registered_vehicles, :collected_fees

  # Initialize facility object
  def initialize(facility_details)
    @name = facility_details[:name]
    @address = facility_details[:address]
    @phone = facility_details[:phone]
    @services = []
    @registered_vehicles = []
    @collected_fees = 0
  end

  # Add service to the facility's services array
  def add_service(service)
    @services << service
  end

  # Register vehicle 
  def register_vehicle(car)
    if @services.include?('Vehicle Registration') # Register vehicle only if facility has this service
      @registered_vehicles << car # Added registered vehicle to the facility's registered_vehicles array
      car.registration_date = Date.today # Assign vehicles reigstration date to the day registered
      if car.antique?   # Change vehicles plate_type based on age or engine type
        car.plate_type = :antique
        @collected_fees += 25 # Add 25 dollar fee to facility's collected_fees
      elsif car.electric_vehicle?
        car.plate_type = :ev
        @collected_fees += 200  # Add 200 dollar fee to facility's collected_fees
      else
        car.plate_type = :regular
        @collected_fees += 100  # Add 100 dollar fee to facility's collected_fees
      end
    else
      return nil  # Return nil if facility doesn't include vehicle registration
    end
  end

  # Administer written license test to registrant
  def administer_written_test(registrant)
    if @services.include?('Written Test') # Administer written license test if facility includes this service
      if registrant.age < 16 # Only administer written license test to registrants that are 16 or older
        return false
      else
        if registrant.permit? == false # Only administer written license test to registrants who already has a permit
          return false
        else
          registrant.license_data[:written] = true # Reassign registant's written test license data to true
          return true # Return true if written test successfully administered
        end
      end
    else
      return false  # Return false if facility doesn't inlcude written test
    end
  end

  def administer_road_test(registrant)
    if @services.include?('Road Test')  # Administer road license test if facility includes this service
      return false if registrant.age < 16 # Only adminsiter road test if registrant is 16 or older
       
      if registrant.permit? == false # Only administer road test if registrant has a permit
        return false
      else
        if registrant.license_data[:written] == false # Only adminsiter road test if registrant has already passed the written test
          return false
        else 
          registrant.license_data[:license] = true # Reassign registant's license status in license data to true
          return true  # Return true if road test is successfully administered
        end
      end
    else
      return false # Return false if facility doesn't inlcude road test
    end
  end
end