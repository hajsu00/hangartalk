class GliderGroupFlight < ApplicationRecord
  belongs_to :group

  def each_egroup_flight_time
    self.landing_time - self.takeoff_time
  end
end
