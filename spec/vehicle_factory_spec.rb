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
    xit 'can create an array of new vehicle objects from DmvDataService' do
      # expect(@factory.create_vehicles(@wa_ev_registrations)).to eq()
    end
  end
end