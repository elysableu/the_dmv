require 'spec_helper'

RSpec.describe VehicleFactory do
  before(:each) do
    @factory = VehicleFactory.new
    @wa_ev_registrations = DmvDataService.new.wa_ev_registrations
  end
  describe '#initialize' do
    it 'can create new VehicleFactory object' do
      expect(@factory).to be_an_instance_of(VehicleFactory)
    end
  end

  describe '#create_vehicles' do
    it 'can create an array of new vehicle objects from DmvDataService' do
      expect(@factory.created_vehicles).to be_empty
      @factory.create_vehicles(@wa_ev_registrations)
      expect(@factory.created_vehicles.length).to eq(@wa_ev_registrations.length)
      expect(@factory.created_vehicles[0..2].map(&:make)).to eq(["NISSAN", "TESLA", "TESLA"])
    end
  end
end