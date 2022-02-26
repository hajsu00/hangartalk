class GliderFlight < ApplicationRecord
  include ActionView::Helpers
  belongs_to :user, optional: true

  validates :user_id, :date, :takeoff_time, :landing_time, presence: true
  validate :check_glider_timeline, :duplication_check

  before_validation :fix_takeoff_time, :fix_landing_time
  before_save :convert_nil_to_false

  # 離陸時刻の日付をユーザーが入力した日付に合わせる
  def fix_takeoff_time
    inputed_time = self.takeoff_time
    inputed_date = self.date
    self.takeoff_time = Time.local(inputed_date.year, inputed_date.month, inputed_date.day, inputed_time.hour, inputed_time.min, 0, 0)
  end

  # 着陸時刻の日付をユーザーが入力した日付に合わせる
  def fix_landing_time
    inputed_time = self.landing_time
    inputed_date = self.date
    self.landing_time = Time.local(inputed_date.year, inputed_date.month, inputed_date.day, inputed_time.hour, inputed_time.min, 0, 0)
  end

  # 値がnilの場合はfalseを代入する
  def convert_nil_to_false
    self.is_motor_glider = false if self.is_motor_glider.nil?
    self.is_power_flight = false if self.is_power_flight.nil?
    self.is_cross_country = false if self.is_cross_country.nil?
    self.is_instructor = false if self.is_instructor.nil?
    self.is_stall_recovery = false if self.is_stall_recovery.nil?
    self.close_log = false if self.close_log.nil?
    self.is_motor_glider = false if self.is_motor_glider.nil?
  end

  # バリデーション
  def check_glider_timeline
    if !self.takeoff_time.nil? && !landing_time.nil?
      user = User.find(user_id)
      initial_date = GliderInitialLog.find_by(user_id: user.id).at_present
      if self.takeoff_time > landing_time
        errors.add(:base, "着陸時刻が離陸時刻よりも前になっています。")
      elsif self.takeoff_time == landing_time
        errors.add(:base, "離陸時刻と着陸時刻が同じです。")
      elsif self.date < initial_date
        errors.add(:base, "フライト日がログ取得開始日より前になっています。")
      end
    end
  end

  def duplication_check
    glider_flights = GliderFlight.where("user_id = ?", user.id).order(takeoff_time: :asc)
    glider_flights.each do |glider_flight|
      if self.log_number != glider_flight.log_number
        if (self.takeoff_time..self.landing_time).cover? glider_flight.takeoff_time
          errors.add(:base, "フライト時間が既存のフライトと重複しています。")
        elsif (self.takeoff_time..self.landing_time).cover? glider_flight.landing_time
          errors.add(:base, "フライト時間が既存のフライトと重複しています。")
        end
      end
    end
  end
end
