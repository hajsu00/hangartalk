# ユーザー
# メインのサンプルユーザーを1人作成する
ActionMailer::Base.perform_deliveries = false
user = User.create!(name: "Example User",
                    email: "example@railstutorial.org",
                    introduction: "ここはユーザーのプロフィール文です。入力可能な文字数は１６０字にする予定です。ここはユーザーのプロフィール文です。入力可能な文字数は１６０字にする予定です。ここはユーザーのプロフィール文です。入力可能な文字数は１６０字にする予定です。ここはユーザーのプロフィール文です。入力可能な文字数は１６０字にする予定です。",
                    location: "東京",
                    password: "foobar",
                    password_confirmation: "foobar",
                    admin: true,
                    confirmed_at: Time.zone.now)
user.avatar.attach(io: File.open(Rails.root.join('app/assets/images/default_avatar.png')), filename: 'default_avatar.png')
user.user_cover.attach(io: File.open(Rails.root.join('app/assets/images/default_cover.png')), filename: 'default_cover.png')

user = User.find(1)
license = user.licenses.create!(code: 'A1111111',
                                license_category_id: 1,
                                aircraft_category_id: 1,
                                date_of_issue: Date.today - 3.years)
license.reccurent_histories.create!(date: license.date_of_issue, valid_for: 2)

user = User.find(1)
license = user.licenses.create!(code: 'A2222222',
                                license_category_id: 2,
                                aircraft_category_id: 1,
                                date_of_issue: Date.today - 3.years)
license.reccurent_histories.create!(date: license.date_of_issue, valid_for: 2)

LicenseCategory.create!(name: '自家用操縦士')
LicenseCategory.create!(name: '事業用操縦士')
LicenseCategory.create!(name: '準定期運送用操縦士')
LicenseCategory.create!(name: '定期運送用操縦士')

AircraftCategory.create!(name: '上級滑空機')
AircraftCategory.create!(name: '飛行機')

# 追加のユーザーをまとめて生成する
ActionMailer::Base.perform_deliveries = false
m = 0
39.times do |n|
  name  = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  password = "password"
  user = User.create!(name: name,
                      email: email,
                      introduction: "ここはユーザーのプロフィール文です。入力可能な文字数は１６０字にする予定です。ここはユーザーのプロフィール文です。入力可能な文字数は１６０字にする予定です。ここはユーザーのプロフィール文です。入力可能な文字数は１６０字にする予定です。ここはユーザーのプロフィール文です。入力可能な文字数は１６０字にする予定です。",
                      location: "東京",
                      password: password,
                      password_confirmation: password)
  if (2 * n + 1) % 3 == 0
    m += 1
    user.avatar.attach(io: File.open(Rails.root.join("app/assets/images/test/user_test_avatar/user_test_avatar_#{m + 1}.png")), filename: "user_test_avatar_#{m + 1}.png")
    user.user_cover.attach(io: File.open(Rails.root.join("app/assets/images/test/user_test_cover/user_test_cover_#{m + 1}.jpg")), filename: "user_test_cover_#{m + 1}.jpg")
  else
    user.avatar.attach(io: File.open(Rails.root.join('app/assets/images/default_avatar.png')), filename: 'default_avatar.png')
    user.user_cover.attach(io: File.open(Rails.root.join('app/assets/images/default_cover.png')), filename: 'default_cover.png')
  end
end

# ユーザーの一部を対象にマイクロポストを生成する
users = User.order(:created_at).take(6)
50.times do |n|
  content = Faker::Lorem.sentence(word_count: 5)
  users.each do |user|
    user.microposts.create!(content: content, is_flight_attached: false, is_sharing_micropost: false, created_at: Time.zone.now - n.minutes,
                            updated_at: Time.zone.now - n.minutes)
  end
end

# 以下のリレーションシップを作成する
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

user = User.find_by(email: "example@railstutorial.org")
date = Date.new(2021, 0o2, 10)
user.create_glider_initial_log(at_present: date,
                               total_time: 67_680,
                               total_number: 188,
                               pic_winch_time: 7_560,
                               pic_winch_number: 21,
                               pic_aero_tow_time: 0,
                               pic_aero_tow_number: 0,
                               solo_winch_time: 15_840,
                               solo_winch_number: 44,
                               solo_aero_tow_time: 0,
                               solo_aero_tow_number: 0,
                               dual_winch_time: 44_280,
                               dual_winch_number: 123,
                               dual_aero_tow_time: 0,
                               dual_aero_tow_number: 0,
                               cross_country_time: 0,
                               instructor_time: 0,
                               instructor_number: 0,
                               number_of_stall_recovery: 3)

# 一部のユーザーを対象にフライト記録を生成する
user = User.find_by(email: "example@railstutorial.org")
23.times do |n|
  # departure_date = Time.zone.today
  # takeoff_time = Time.current + ((n + 1) * 60).minutes
  departure_date = Date.today - 1.year
  takeoff_time = Time.current.change(year: departure_date.year) + ((n + 1) * 60).minutes
  landing_time = takeoff_time + 6.minutes
  user.glider_flights.create!(log_number: 1 + n,
                              date: departure_date,
                              glider_type: 1,
                              glider_ident: 'JA21MA',
                              departure_and_arrival_point: '宝珠花滑空場',
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
end

user = User.find_by(email: "example@railstutorial.org")
3.times do |n|
  n += 1
  group = Group.new(name: "テストグループ#{n}", introduction: "これはグループ#{n}の紹介文です。字数制限は今のところありません。", privacy: "プライベート")
  group.users << user if group.save
  group.group_cover.attach(io: File.open(Rails.root.join('app/assets/images/default_cover.png')), filename: 'default_cover.png')
end

users = User.order(created_at: :DESC).take(3)
group = Group.find_by(name: "テストグループ1")
users.each do |user|
  group.users << user
end

AircraftType.create!(aircraft_type: 'ASK21', category: 'glider')
AircraftType.create!(aircraft_type: 'ASK21B', category: 'glider')
AircraftType.create!(aircraft_type: 'ASK23b', category: 'glider')
AircraftType.create!(aircraft_type: 'Cessna 152', category: 'aeroplane')
AircraftType.create!(aircraft_type: 'Cessna 172', category: 'aeroplane')

group = Group.find(1)
group.fleets.create!(ident: 'JA21MA', aircraft_type_id: 1)
group.fleets.create!(ident: 'JA21MB', aircraft_type_id: 2)
group.fleets.create!(ident: 'JA2381', aircraft_type_id: 3)

group = Group.find(3)
group.fleets.create!(ident: 'JA2400', aircraft_type_id: 1)

group = Group.find(1)
date = Date.new(2022, 2, 21)
takeoff_time = Time.zone.local(2022, 2, 21, 21, 0, 0)
group.glider_group_flights.create(day_flight_number: nil,
                                  date: date,
                                  departure_and_arrival_point: '宝珠花滑空場',
                                  is_winch: true,
                                  fleet: 1,
                                  front_seat: 40,
                                  front_flight_role: '同乗教育',
                                  rear_seat: 1,
                                  rear_flight_role: '教官',
                                  takeoff_time: takeoff_time,
                                  release_time: takeoff_time + 1.minute,
                                  landing_time: takeoff_time + 12.minutes,
                                  release_alt: 400,
                                  creator: 1,
                                  notes: '備考欄です')
group = Group.find(1)
date = Date.new(2022, 2, 21)
takeoff_time = Time.zone.local(2022, 2, 21, 21, 20, 0)
group.glider_group_flights.create(day_flight_number: nil,
                                  date: date,
                                  departure_and_arrival_point: '宝珠花滑空場',
                                  is_winch: true,
                                  fleet: 1,
                                  front_seat: 39,
                                  front_flight_role: '同乗教育',
                                  rear_seat: 1,
                                  rear_flight_role: '教官',
                                  takeoff_time: takeoff_time,
                                  release_time: takeoff_time + 1.minute,
                                  landing_time: takeoff_time + 12.minutes,
                                  release_alt: 400,
                                  creator: 1,
                                  notes: '備考欄です')
