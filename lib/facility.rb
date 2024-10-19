class Facility
  attr_reader :name, :address, :phone, :services, :registered_vehicles, :collected_fees

  def initialize(facility_details)
    @name = facility_details[:name]
    @address = facility_details[:address]
    @phone = facility_details[:phone]
    @services = []
    @registered_vehicles = []
    @collected_fees = 0
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle(car)
    if @services.include?('Vehicle Registration')
      @registered_vehicles << car
      car.registration_date = Date.today
      if car.antique? 
        car.plate_type = :antique
      elsif car.electric_vehicle?
        car.plate_type = :ev
      else
        car.plate_type = :regular
      end
    else
      return nil
    end
  end
end
