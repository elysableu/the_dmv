require 'spec_helper'

RSpec.describe Registrant do
  before(:each) do 
    @darren = Registrant.new('Darren', 18)
    @freddie = Registrant.new('Freddie', 17, true)
    @lucy = Registrant.new('Lucy', 38)
  end
  describe '#initialize' do
    it 'can initialize' do
      expect(@darren).to be_an_instance_of(Registrant)
      expect(@darren.age).to eq(15)
      expect(@darren.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
      expect(@darren.name).to eq('Darren')
    end
  end

  describe '#permit?' do
    it 'is false by default' do
      expect(@darren.permit?).to be false
    end

    it 'can determine if a registrant has a permit' do
      expect(@freddie.permit?).to be true
      expect(@lucy.permit?).to be false
    end
  end

  describe '#earn_permit' do
    it 'can change permit status' do
      expect(@lucy.permit?).to be false

      @lucy.earn_permit

      expect(@lucy.permit?).to be true
    end
  end
end