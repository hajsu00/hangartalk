class License < ApplicationRecord
  belongs_to :user

  validates :user_id, uniqueness: { scope: [:license_category_id, :aircraft_category_id] }

  def show_license_category
    LicenseCategory.find(self.license_category_id).name
  end

  def show_aircraft_category
    AircraftCategory.find(self.aircraft_category_id).name
  end
end
