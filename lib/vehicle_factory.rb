class VehicleFactory
  attr_reader :created_vehicles

  def initialize
    @created_vehicles = []
  end

  def create_vehicles(dmv_data)
    dmv_data.each do |dmv_entry|
      new_vehicle = Vehicle.new({ vin: dmv_entry[:vin_1_10], 
                    year: dmv_entry[:model_year],
                    make: dmv_entry[:make],
                    model: dmv_entry[:model],
                    engine: :ev})

      @created_vehicles << new_vehicle
    end
  end
end