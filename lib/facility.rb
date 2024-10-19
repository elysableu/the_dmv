class Facility
  attr_reader :name, :address, :phone, :services, :vehicle_registration

  def initialize(facility_details)
    @name = facility_details[:name]
    @address = facility_details[:address]
    @phone = facility_details[:phone]
    @services = []
    @registered_vehicles = []
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle
    if @services.include?('Vehicle Registration')

    end
  end
end
