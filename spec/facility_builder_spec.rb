require 'spec_helper'

RSpec.describe FacilityBuilder do
  before(:each) do
    @builder = FacilityBuilder.new
    @co_dmv_office_locations = DmvDataService.new.co_dmv_office_locations
  end
  describe '#initialize' do
    it 'can create new FacilityBuilder object' do
    
    end
  end

  describe '#build facility' do
    it 'can build an array of new facility objects' do
      
    end
  end
end