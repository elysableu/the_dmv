require 'spec_helper'

RSpec.describe FacilityBuilder do
  before(:each) do
    @builder = FacilityBuilder.new
    @co_dmv_office_locations = DmvDataService.new.co_dmv_office_locations
  end
  describe '#initialize' do
    it 'can create new FacilityBuilder object' do
      expect(@builder).to be_an_instance_of(FacilityBuilder)
    end
  end

  describe '#build facility' do
    it 'can build an array of new facility objects' do
      expect(@builder.facilities).to be_empty
      @builder.build_facility_data(@co_dmv_office_locations)
      expect(@builder.facilities.length).to eq(@co_dmv_office_locations.length)
      expect(@builder.facilities[0..2].map(&:name)).to eq(["DMV Tremont Branch", "DMV Northeast Branch", "DMV Northwest Branch"])
    end
  end

  describe '#format_facility_services' do
    it 'can add services to the new facility object' do
      @builder.build_facility_data(@co_dmv_office_locations)
      expect(@builder.facilities[0].services).to eq(["vehicle titles", "registration", "renewals", "VIN inspections"])
    end
  end
end