class License < ApplicationRecord
  belongs_to :user
  has_many :reccurent_histories, dependent: :destroy

  validates :user_id, uniqueness: { scope: [:license_category_id, :aircraft_category_id] }

  def show_license_category
    LicenseCategory.find(self.license_category_id).name
  end

  def show_aircraft_category
    AircraftCategory.find(self.aircraft_category_id).name
  end

  def is_valid_license?
    expired_date = self.reccurent_histories.last.date + self.reccurent_histories.last.valid_for.years
    expired_date > Date.today
  end
end
