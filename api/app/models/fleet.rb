class Fleet < ApplicationRecord
  belongs_to :group

  def show_fleet
    aircraft = AircraftType.find_by(id: self.aircraft_type_id)
    "#{aircraft.aircraft_type} (#{self.ident})"
  end
end
