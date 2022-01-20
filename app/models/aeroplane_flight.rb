class AeroplaneFlight < ApplicationRecord
  belongs_to :user
  validates :departure_date, :aeroplane_type, :aeroplane_ident, :user_id, :moving_time, :stop_time, presence: true
  validate :time_order_check

  # Check if input time order is proper
  def time_order_check
    self.moving_time < stop_time unless self.moving_time.nil? && stop_time.nil?
  end
end
