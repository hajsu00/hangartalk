class AeroplaneFlight < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, :moving_time, :stop_time, presence: true
  validate :time_order_check

  # Check if input time order is proper
  def time_order_check
    self.moving_time < stop_time
  end
end
