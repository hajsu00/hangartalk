class GliderFlight < ApplicationRecord
  include ActionView::Helpers

  belongs_to :user
  belongs_to :user, optional: true

  validates :takeoff_time, :landing_time, presence: true
  validate :check_glider_timeline

  def check_glider_timeline
    if !self.takeoff_time.nil? && !landing_time.nil?
      if self.takeoff_time > landing_time
        errors.add(:base, "離陸時刻が着陸時刻よりも遅くなっています。")
      elsif self.takeoff_time == landing_time
        binding.pry
        errors.add(:base, "離陸時刻と着陸時刻が同じです。")
      # else
      #   glider_flights = GliderFlight.where("user_id = ?", current_user.id).order(takeoff_time: :asc)
      #   glider_flights.each do |glider_flight|
      #     if glider_flight.takeoff_time < self.takeoff_time && self.takeoff_time < glider_flight.landing_time
      #       errors.add(:base, "フライト時間が既存のログと重複しています。")
      #     elsif glider_flight.takeoff_time < self.landing_time && self.landing_time < glider_flight.landing_time
      #       errors.add(:base, "フライト時間が既存のログと重複しています。")
      #     end
      #   end
      end
    end
  end
end
