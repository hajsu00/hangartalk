class License < ApplicationRecord
  belongs_to :user

  def show_license_category
    LicenseCategory.find(self.license_category).name
  end
end
