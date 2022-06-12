class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :licenses, dependent: :destroy
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :aeroplane_flights, dependent: :destroy
  has_many :glider_flights, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :like_rekationships, dependent: :destroy

  has_one :aeroplane_initial_log, dependent: :destroy
  has_one :glider_initial_log, dependent: :destroy

  has_one_attached :avatar
  has_one_attached :user_cover

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }

  def self.guest
    user = find_by(email: 'guest@example.com')
    if user.nil?
      user = User.create!(name: "ゲストユーザー",
        email: "guest@example.com",
        introduction: "パイロットになりたい22歳大学生。大学の部活でグライダーを飛ばしていて、2年生の時に操縦ライセンスを取得しました。同じ志を持つ方と仲良くなりたいです。よろしくお願いします！",
        location: "東京",
        password: SecureRandom.urlsafe_base64,
        admin: false,
        confirmed_at: Time.zone.now)
      # プロフィール画像等の登録
      user.avatar.attach(io: File.open(Rails.root.join('app/assets/images/guest_user_avatar.jpg')), filename: 'guest_user_avatar.jpg')
      user.user_cover.attach(io: File.open(Rails.root.join('app/assets/images/guest_user_cover.jpg')), filename: 'guest_user_cover.jpg')
      # ライセンスの登録
      license = user.licenses.create!(code: 'A1111111',
        license_category_id: 1,
        aircraft_category_id: 1,
        date_of_issue: Date.today - 3.years)
      license.reccurent_histories.create!(date: license.date_of_issue, valid_for: 2)
      license.reccurent_histories.create!(date: license.date_of_issue + 2.years, valid_for: 2)
      # ユーザーのリレーションシップを作成する
      users = User.all
      following = users[2..38]
      followers = users[3..25]
      following.each { |followed| user.follow(followed) }
      followers.each { |follower| follower.follow(user) }
      # フライト経験
      user.create_glider_initial_log(at_present: Date.today - 3.years,
        total_time: 0,
        total_number: 0,
        pic_winch_time: 0,
        pic_winch_number: 0,
        pic_aero_tow_time: 0,
        pic_aero_tow_number: 0,
        solo_winch_time: 0,
        solo_winch_number: 0,
        solo_aero_tow_time: 0,
        solo_aero_tow_number: 0,
        dual_winch_time: 0,
        dual_winch_number: 0,
        dual_aero_tow_time: 0,
        dual_aero_tow_number: 0,
        cross_country_time: 0,
        instructor_time: 0,
        instructor_number: 0,
        number_of_stall_recovery: 0)
      # フライトを追加する
      75.times do |n|
        departure_date = Date.today - 2.year + (n + 1).day
        takeoff_time = Time.current.change(year: departure_date.year, day: departure_date.day) + (((n + 3) % 3) * 60).minute
        landing_time = takeoff_time + 6.minutes
        glider_flight = user.glider_flights.build(log_number: 1 + n,
                                    date: departure_date,
                                    glider_ident: 'JA21MA',
                                    departure_point: '宝珠花滑空場',
                                    arrival_point: '宝珠花滑空場',
                                    number_of_landing: 1,
                                    takeoff_time: takeoff_time,
                                    landing_time: landing_time,
                                    flight_role: '同乗教育',
                                    is_winch: true,
                                    is_cross_country: false,
                                    release_alt: 420,
                                    is_instructor: false,
                                    is_stall_recovery: false,
                                    note: '備考欄です。')
        glider_flight.aircraft_type_id = 1
        glider_flight.save(validate: false)
      end
      42.times do |n|
        departure_date = Date.today - 1.year + (n + 1).day
        takeoff_time = Time.current.change(year: departure_date.year, day: departure_date.day) + (((n + 3) % 3) * 60).minute
        landing_time = takeoff_time + 10.minutes
        glider_flight = user.glider_flights.build(log_number: 76 + n,
                                    date: departure_date,
                                    glider_ident: 'JA2381',
                                    departure_point: '宝珠花滑空場',
                                    arrival_point: '宝珠花滑空場',
                                    number_of_landing: 1,
                                    takeoff_time: takeoff_time,
                                    landing_time: landing_time,
                                    flight_role: '機長',
                                    is_winch: true,
                                    is_cross_country: false,
                                    release_alt: 420,
                                    is_instructor: false,
                                    is_stall_recovery: false,
                                    note: '備考欄です。')
        glider_flight.aircraft_type_id = 3
        glider_flight.save(validate: false)
      end
    end
    return user
  end

  # cookieを使いログイン情報を保持
  def remember_me
    true
  end

  # ユーザーのステータスフィードを返す
  def feed
    following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id",
                    user_id: id).includes([:images_attachments, :like_relationships,
                      :replying,
                      :replied,
                      :sharing,
                      :shared,
                      :glider_flight,
                      { replying: :replying_relationships, replied: :replied_relationships, sharing: :sharing_relationships, shared: :shared_relationships, glider_flight: :glider_micropost_relationships }])
  end

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  # 現在のユーザーがグループに所属していたらtrueを返す
  def belong_any_groups?
    any_group = GroupUser.find_by(user_id: self.id)
    true unless any_group.nil?
  end
end
