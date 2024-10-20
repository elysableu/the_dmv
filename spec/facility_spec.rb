require 'spec_helper'

RSpec.describe Facility do
  before(:each) do
    @facility_1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
    @facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
    @cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
    @bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
    @camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )
    @registrant_1 = Registrant.new('Bruce', 18, true )
    @registrant_2 = Registrant.new('Penny', 16 )
    @registrant_3 = Registrant.new('Tucker', 15 )
  end
  describe '#initialize' do
    it 'can initialize' do
      expect(@facility_1).to be_an_instance_of(Facility)
      expect(@facility_1.name).to eq('DMV Tremont Branch')
      expect(@facility_1.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(@facility_1.phone).to eq('(720) 865-4600')
      expect(@facility_1.services).to eq([])
    end
  end

  describe '#add service' do
    it 'can add available services' do
      expect(@facility_1.services).to eq([])
      @facility_1.add_service('New Drivers License')
      @facility_1.add_service('Renew Drivers License')
      @facility_1.add_service('Vehicle Registration')
      expect(@facility_1.services).to eq(['New Drivers License', 'Renew Drivers License', 'Vehicle Registration'])
    end
  end

  describe '#register_vehicle' do
    it 'can only register vehicles when faciltiy includes this service' do
      expect(@facility_1.register_vehicle(@cruz)).to eq(nil)

      @facility_1.add_service('Vehicle Registration')

      expect(@facility_1.register_vehicle(@cruz)).to be_truthy
    end

    it 'can add vehicle registration to facility services' do
      @facility_1.add_service('Vehicle Registration')
      expect(@facility_1.services).to eq(['Vehicle Registration'])
    end

    it 'can access car default registration date' do
     expect(@cruz.registration_date).to eq(nil)
    end

    it 'has registered_vehicles lists defaults as empty' do
      expect(@facility_1.registered_vehicles).to eq([])
    end

    it 'has collected fees defaults as 0' do
      expect(@facility_1.collected_fees).to eq(0)
    end

    it 'can add vehicle to registered_vehicles when registered' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@cruz)
      @facility_1.register_vehicle(@camaro)
      @facility_1.register_vehicle(@bolt)

      expect(@facility_1.registered_vehicles[0]).to eq(@cruz)
      expect(@facility_1.registered_vehicles[1]).to eq(@camaro)
      expect(@facility_1.registered_vehicles[2]).to eq(@bolt)
    end

    it 'can set registration_date when registered' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@cruz)
      @facility_1.register_vehicle(@camaro)
      @facility_1.register_vehicle(@bolt)

      expect(@cruz.registration_date).to eq(Date.today)
      expect(@camaro.registration_date).to eq(Date.today)
      expect(@bolt.registration_date).to eq(Date.today)
    end

    it 'can update plate_type when registered' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@cruz)
      @facility_1.register_vehicle(@camaro)
      @facility_1.register_vehicle(@bolt)

      expect(@cruz.plate_type).to eq(:regular)
      expect(@camaro.plate_type).to eq(:antique)
      expect(@bolt.plate_type).to eq(:ev)
    end

    it 'can update registered_vehicles' do
      @facility_1.add_service('Vehicle Registration')
      
      @facility_1.register_vehicle(@cruz)
      expect(@facility_1.registered_vehicles).to eq([@cruz])

      @facility_1.register_vehicle(@camaro)
      expect(@facility_1.registered_vehicles).to eq([@cruz, @camaro])
      
      @facility_1.register_vehicle(@bolt)
      expect(@facility_1.registered_vehicles).to eq([@cruz, @camaro, @bolt])
    end
    
    it 'can collect fees for registration' do
      @facility_1.add_service('Vehicle Registration')

      @facility_1.register_vehicle(@cruz)
      expect(@facility_1.collected_fees).to eq(100)

      @facility_1.register_vehicle(@camaro)
      expect(@facility_1.collected_fees).to eq(125)

      @facility_1.register_vehicle(@bolt)
      expect(@facility_1.collected_fees).to eq(325)

    end

    it 'can register vehicles at multiple facilities' do
      expect(@facility_2.registered_vehicles).to eq([])
      expect(@facility_2.services).to eq([])
      expect(@facility_2.register_vehicle(@bolt)).to eq(nil)
      expect(@facility_2.registered_vehicles).to eq([])
      expect(@facility_2.collected_fees).to eq(0)
    end
  end

  describe '#administer_written_test' do
    it 'can read registrant license data' do 
      expect(@registrant_1.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
    end

    it 'can access registrant permit status' do
      expect(@registrant_1.permit?).to be true
    end

    it 'can access registrant age' do 
      expect(@registrant_1.age).to eq(18)
    end

    it 'can add Written Test to facility services' do
      expect(@facility_1.services).to eq([])

      @facility_1.add_service('Written Test')

      expect(@facility_1.services).to eq(['Written Test'])
    end

    it 'can only administer written test when faciltiy includes this service' do
      expect(@facility_1.administer_written_test(@registrant_1)).to be false

      @facility_1.add_service('Written Test')

      expect(@facility_1.administer_written_test(@registrant_1)).to be true
    end

    it 'can administer written test to registrant' do
      @facility_1.add_service('Written Test')

      expect(@facility_1.administer_written_test(@registrant_1)).to be true
    end 

    it 'can administer written test only to registrants with a permit' do
      @facility_1.add_service('Written Test')

      expect(@facility_1.administer_written_test(@registrant_2)).to be false

      @registrant_2.earn_permit

      expect(@facility_1.administer_written_test(@registrant_2)).to be true
    end

    it 'can adminster written test only to registrants 16 years old or older' do
      @facility_1.add_service('Written Test')

      expect(@facility_1.administer_written_test(@registrant_3)).to be false

      @registrant_3.earn_permit

      expect(@facility_1.administer_written_test(@registrant_3)).to be false
    end

    it 'can update license data for written test after passing test' do
      @facility_1.add_service('Written Test')

      expect(@registrant_1.license_data).to eq({:written=>false, :license=>false, :renewed=>false})

      @facility_1.administer_written_test(@registrant_1)

      expect(@registrant_1.license_data).to eq({:written=>true, :license=>false, :renewed=>false})
    end
  end

  describe '#administer_road_test' do
    xit 'can get registrant license data' do

    end

    xit 'can add road test to the list of facility services' do

    end

    xit 'can only administer road test when faciltiy includes this service' do
      
    end

    xit 'can only administer road teset to registrant with a permit' do

    end

    xit 'can only administer road test after registrant has passed written test' do

    end

    xit 'can update license data when road test is passed' do

    end
  end

  describe '#renew_drivers_license' do

  end
end
