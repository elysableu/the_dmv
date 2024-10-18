require 'spec_helper'

RSpec.describe Registrant do
  before(:each) do 
    @darren = Registrant.new({name: 'Darren', age: 15})
    @freddie = Registrant.new({name: 'Freddie', age: 17, permit: true})
    @lucy = Registrant.new({name: 'Lucy', age: 32})
  end
  describe '#initialize' do
    xit 'can initialize' do
      expect(@darren).to be_an_instance_of(Registrant)
      expect(@darren.age).to eq(22)
      expect(@darren.license_data). eq( )
      expect(@darren.name).to eq('Darren')
      expect(@darren.permit).to be true
    end
  end

  describe '#permit?' do
    xit 'is false by default' do
      expect(@darren.permit?).to be false
    end

    xit 'can determine if a registrant has a permit' do
      expect(@freddie.permit?).to be true
      expect(@lucy.permit?).to be false
    end
  end

  describe '#earn_permit' do
    xit 'can change permit status' do
      expect(@lucy.permit?).to be false

      @lucy.earn_permit

      expect(@lucy.permit?).to be true
    end
  end
end