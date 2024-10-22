class FacilityBuilder
  attr_reader :facilities

  def initialize
    @facilities = []
  end

  def build_facility_data(dmv_data)
    dmv_data.each do |dmv_entry|
      new_facility = Facility.new({ name: dmv_entry[:dmv_office],
                      address: "#{dmv_entry[:address_li]} #{dmv_entry[:address_1]} \n #{dmv_entry[:city]} #{dmv_entry[:state]} #{dmv_entry[:zip]}",
                      phone: dmv_entry[:phone]
                      })
      @facilities << new_facility      
    end
  end
end
