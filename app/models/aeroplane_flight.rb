class AeroplaneFlight < ApplicationRecord
  belongs_to :user
  validates :departure_date, :aeroplane_type, :aeroplane_ident, :user_id, :moving_time, :stop_time, presence: true
  validate :check_aeroplane_timline

  # Check if input time order is proper
  def check_aeroplane_timline
    unless self.moving_time.nil? && stop_time.nil?
      self.moving_time < stop_time
    end
  end
end