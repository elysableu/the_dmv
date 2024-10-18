class Registrant 
  attr_reader :age, :license_data, :name

  def initialize(regsitrant_details)
    @age = regsitrant_details[:age]
    @license_data = {
      :written => false,
      :license => false,
      :renewed => false
    }
    @name = regsitrant_details[:name]
    @permit = regsitrant_details[:permit] || false # Permit status is false by default
  end

  # Returns status of registrants permit 
  def permit?
    @permit
  end

  # Updates registant's permit status
  def earn_permit
    @permit = true
  end
end