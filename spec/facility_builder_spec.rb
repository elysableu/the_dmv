require 'spec_helper'

RSpec.describe FacilityBuilder do
  before(:each) do
    @builder = FacilityBuilder.new
    @co_dmv_office_locations = DmvDataService.new.co_dmv_office_locations
    @ny_dmv_locations = DmvDataService.new.ny_dmv_office_locations
    @mo_dmv_locations = DmvDataService.new.mo_dmv_office_locations
    @co_facilities = []
    @ny_facilities = []
    @mo_facilities = []
  end

  describe '#initialize' do
    it 'can create new FacilityBuilder object' do
      expect(@builder).to be_an_instance_of(FacilityBuilder)
    end
  end

  describe '#build facility' do
    it 'can build an array of new facility objects' do
      expect(@co_facilities).to be_empty
      co_facilities = @builder.build_facility_data(@co_dmv_office_locations)
      expect(co_facilities.length).to eq(@co_dmv_office_locations.length)
      expect(co_facilities[0..2].map(&:name)).to eq(["DMV Tremont Branch", "DMV Northeast Branch", "DMV Northwest Branch"])
    end

    it 'can accept facility data from another data sources' do
      expect(@ny_facilities).to be_empty
      puts @ny_dmv_office_locations
      @ny_facilities = @builder.build_facility_data(@ny_dmv_office_locations)
      expect(@ny_facilities.length).to eq(@ny_dmv_office_locations.length)
      expect(@ny_facilities[0..2].map(&:name)).to eq(["LAKE PLACID", "HUDSON", "RIVERHEAD KIOSK"])
    end

    xit 'can accept facility data from YET another data source' do
      expect(@mo_facilities).to be_empty
      @mo_facilities = @builder.build_facility_data(@mo_dmv_office_locations)
      expect(@mo_facilities.length).to eq(@mo_dmv_office_locations.length)
      expect(@mo_facilities[0..2].map(&:name)).to eq(["FERGUSON-OFFICE CLOSED UNTIL FURTHER NOTICE", "BUTLER", "CENTRAL WENT END"])
    end
  end

  describe '#format_address'do
    it 'can format address' do
      co_facilities = @builder.build_facility_data(@co_dmv_office_locations)
      expect(co_facilities[0].address).to eq("2855 Tremont Place, Suite 118 Denver, CO 80205")
    end
  end

  describe '#format_facility_services' do
    it 'can add services to the new facility object' do
      co_facilities = @builder.build_facility_data(@co_dmv_office_locations)
      expect(co_facilities[0].services).to eq(["vehicle titles", "registration", "renewals", "VIN inspections"])
    end
  end
end