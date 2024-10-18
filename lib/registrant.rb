class Registrant 
  attr_reader :age, :license_data, :name

  # Initialize registrant object
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

  # Check registrants permit status
  def permit?
    @permit # Return current status of permit
  end

  # Updates registant's permit status
  def earn_permit
    @permit = true # Change permit status to true when they earn the permit
  end
end