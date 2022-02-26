class AeroplaneFlight < ApplicationRecord
  belongs_to :user
  validates :date, :moving_time, :stop_time, presence: true
  validate :check_aeroplane_timline

  # Check if inputed time order is proper
  def check_aeroplane_timline
    if !self.moving_time.nil? && !stop_time.nil?
      # user = User.find(user_id)
      # initial_date = GliderInitialLog.find_by(user_id: user.id).at_present
      if self.moving_time > stop_time
        errors.add(:base, "到着時刻が出発時刻よりも前になっています。")
      elsif self.moving_time == stop_time
        errors.add(:base, "出発時刻と到着時刻が同じです。")
      # elsif self.date < initial_date
      #   errors.add(:base, "フライト日がログ取得開始日より前になっています。")
      end
    end
  end

  # def duplication_check
  #   glider_flights = GliderFlight.where("user_id = ?", user.id).order(takeoff_time: :asc)
  #   glider_flights.each do |glider_flight|
  #     if self.log_number != glider_flight.log_number
  #       if (self.takeoff_time..self.landing_time).cover? glider_flight.takeoff_time
  #         errors.add(:base, "フライト時間が既存のフライトと重複しています。")
  #       elsif (self.takeoff_time..self.landing_time).cover? glider_flight.landing_time
  #         errors.add(:base, "フライト時間が既存のフライトと重複しています。")
  #       end
  #     end
  #   end
  # end
end