class FacilityBuilder
  def build_facility_data(dmv_data)
    facilities = []
    dmv_data.each do |dmv_entry|
      entry_name = nil
      entry_address = nil
      entry_phone = nil

      if dmv_entry.key?(:dmv_office)
        entry_name = dmv_entry[:dmv_office]
        entry_address = format_address(dmv_entry, 1)
        entry_phone = dmv_entry[:phone]
      elsif dmv_entry.key?(:office_name)
        entry_name = dmv_entry[:office_name]
        entry_address = format_address(dmv_entry, 2)
        entry_phone = dmv_entry[:public_phone_number]
      elsif dmv_entry.key?(:name)
        entry_name = dmv_entry[:name]
        entry_address = format_address(dmv_entry, 3)
        entry_phone = dmv_entry[:phone]
      end

      new_facility = Facility.new(name: entry_name, address: entry_address, phone: entry_phone)
      
      format_facility_services(new_facility, dmv_entry)
      facilities << new_facility      
    end
    return facilities
  end

  def format_address(dmv_entry, source_num)
    if source_num == 1
      return "#{dmv_entry[:address_li]}, #{dmv_entry[:address__1]} #{dmv_entry[:city]}, #{dmv_entry[:state]} #{dmv_entry[:zip]}"
    elsif source_num == 2
      return "#{dmv_entry[:street_address_line_1]} #{dmv_entry[:city]}, #{dmv_entry[:state]} #{dmv_entry[:zip_code]}"
    elsif source_num == 3
      return "#{dmv_entry[:address1]} #{dmv_entry[:city]}, #{dmv_entry[:state]} #{dmv_entry[:zipcode]}"
    end  
  end


  def format_facility_services(new_facility, dmv_entry)
    if dmv_entry.key?(:services_p)
      new_facility_services = dmv_entry[:services_p].split(/[;,]/)
      new_facility_services.each do |service|
        new_facility.add_service(service.strip)
      end
    end
  end
end
