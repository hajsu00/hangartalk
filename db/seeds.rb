# メインのサンプルユーザーを1人作成する
User.create!(name: "株木 達郎", email: "example@railstutorial.org", password: "foobar", password_confirmation: "foobar", admin: true, activated: true, activated_at: Time.zone.now)

# 追加のユーザーをまとめて生成する
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  password = "password"
  User.create!(name: name, email: email, password: password, password_confirmation: password, activated: true, activated_at: Time.zone.now)
end

# ユーザーの一部を対象にマイクロポストを生成する
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end

# 以下のリレーションシップを作成する
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# 一部のユーザーを対象にフライト記録を生成する
# users = User.order(:created_at).take(6)
user = User.find_by(email: "example@railstutorial.org")
123.times do |n|
  departure_date = Time.zone.today
  takeoff_time = Time.current + ((n+1) * 60).minutes
  moving_time = takeoff_time + 6.minutes
  landing_time = takeoff_time + 20.minutes
  stop_time = landing_time + 6.minutes
  user.aeroplane_flights.create!(log_number: 1 + n,
                              departure_date: departure_date,
                              aeroplane_type: 'ASK21',
                              aeroplane_ident: 'JA21MA',
                              departure_point: 'RJTT',
                              arrival_point: 'RJTT',
                              exercises_or_maneuvers: 'T/G, normal procedures',
                              number_of_takeoff: 3,
                              number_of_landing: 3,
                              moving_time: moving_time,
                              stop_time: stop_time,
                              is_pic: false,
                              is_dual: false,
                              is_cross_country: true,
                              is_night_flight: true,
                              is_hood: false,
                              is_instrument: false,
                              is_simulator: false,
                              is_instructor: true,
                              is_stall_recovery: true,
                              close_log: false,
                              note: '備考欄です。')
end

user = User.find_by(email: "example@railstutorial.org")
23.times do |n|
  # departure_date = Time.zone.today
  takeoff_time = Time.current + ((n+1) * 60).minutes
  departure_date = Date.new(takeoff_time.year, takeoff_time.month, takeoff_time.day)
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
                              is_motor_glider: false,
                              is_power_flight: false,
                              is_winch: true,
                              is_cross_country: false,
                              release_alt: 420,
                              is_instructor: false,
                              is_stall_recovery: false,
                              close_log: false,
                              note: '備考欄です。')
end

# user = User.find_by(email: "example@railstutorial.org")
# 13.times do |n|
#   departure_date = Time.zone.today
#   takeoff_time = Time.current + ((n+1) * 60).minutes
#   landing_time = takeoff_time + 6.minutes
#   user.glider_flights.create!(log_number: 24 + n,
#                               date: departure_date,
#                               aircraft_type: 'ASK21',
#                               glider_ident: 1,
#                               departure_and_arrival_point: '宝珠花滑空場',
#                               number_of_landing: 1,
#                               takeoff_time: takeoff_time,
#                               landing_time: landing_time,
#                               flight_role: '同乗教育',
#                               is_motor_glider: true,
#                               is_power_flight: true,
#                               is_winch: false,
#                               is_cross_country: false,
#                               release_alt: 420,
#                               is_instructor: false,
#                               is_stall_recovery: false,
#                               close_log: false,
#                               note: '備考欄です。')
# end
# user = User.find_by(email: "example@railstutorial.org")
# 13.times do |n|
#   departure_date = Time.zone.today
#   takeoff_time = Time.current + ((n+1) * 60).minutes
#   landing_time = takeoff_time + 6.minutes
#   user.glider_flights.create!(log_number: 37 + n,
#                               date: departure_date,
#                               aircraft_type: 1,
#                               glider_ident: 'JA21MA',
#                               departure_and_arrival_point: '宝珠花滑空場',
#                               number_of_landing: 1,
#                               takeoff_time: takeoff_time,
#                               landing_time: landing_time,
#                               flight_role: '単独飛行',
#                               is_motor_glider: true,
#                               is_power_flight: true,
#                               is_winch: false,
#                               is_cross_country: true,
#                               release_alt: 420,
#                               is_instructor: false,
#                               is_stall_recovery: false,
#                               close_log: false,
#                               note: '備考欄です。')
#end
# user = User.find_by(id: 1)
# departure_date = Time.zone.today
# takeoff_time = Time.current
# moving_time = takeoff_time - 6.minutes
# landing_time = takeoff_time + 10.minutes
# stop_time = landing_time + 6.minutes
# user.aeroplane_flights.create!(log_number: 1,
#                               departure_date: departure_date,
#                               aeroplane_type: 'ask21',
#                               aeroplane_ident: 'ja21ma',
#                               departure_point: 'RJTT',
#                               arrival_point: 'RJTT',
#                               exercises_or_maneuvers: 'T/G, normal procedures',
#                               number_of_takeoff: 3,
#                               number_of_landing: 3,
#                               moving_time: moving_time,
#                               stop_time: stop_time,
#                               is_pic: true,
#                               is_dual: false,
#                               is_cross_country: false,
#                               is_night_flight: false,
#                               is_hood: false,
#                               is_instrument: false,
#                               is_simulator: false,
#                               is_instructor: true,
#                               is_stall_recovery: false,
#                               note: '備考欄です。')
# departure_date = Time.zone.today
# takeoff_time = Time.current + 60.minutes
# moving_time = takeoff_time - 6.minutes
# landing_time = takeoff_time + 10.minutes
# stop_time = landing_time + 6.minutes
# user.aeroplane_flights.create!(log_number: 2,
#                               departure_date: departure_date,
#                               aeroplane_type: 'ask21',
#                               aeroplane_ident: 'ja21ma',
#                               departure_point: 'RJTT',
#                               arrival_point: 'RJAA',
#                               exercises_or_maneuvers: 'T/G, normal procedures',
#                               number_of_takeoff: 3,
#                               number_of_landing: 3,
#                               moving_time: moving_time,
#                               stop_time: stop_time,
#                               is_pic: false,
#                               is_dual: false,
#                               is_cross_country: false,
#                               is_night_flight: false,
#                               is_hood: false,
#                               is_instrument: false,
#                               is_simulator: false,
#                               is_instructor: false,
#                               is_stall_recovery: false,
#                               note: '備考欄です。')
# departure_date = Time.zone.today
# takeoff_time = Time.current + 120.minutes
# moving_time = takeoff_time - 6.minutes
# landing_time = takeoff_time + 10.minutes
# stop_time = landing_time + 6.minutes
# user.aeroplane_flights.create!(log_number: 3,
#                               departure_date: departure_date,
#                               aeroplane_type: 'ask21',
#                               aeroplane_ident: 'ja21ma',
#                               departure_point: 'RJTT',
#                               arrival_point: 'RJOO',
#                               exercises_or_maneuvers: 'night cross country practice',
#                               number_of_takeoff: 1,
#                               number_of_landing: 1,
#                               moving_time: moving_time,
#                               stop_time: stop_time,
#                               is_pic: false,
#                               is_dual: true,
#                               is_cross_country: true,
#                               is_night_flight: true,
#                               is_hood: false,
#                               is_instrument: false,
#                               is_simulator: false,
#                               is_instructor: false,
#                               is_stall_recovery: false,
#                               note: '備考欄です。')

user = User.find_by(email: "example@railstutorial.org")
user.create_aeroplane_initial_log(total_flight_number: 20,
                                  number_of_takeoff: 30,
                                  number_of_landing: 30,
                                  total_time: 108_000,
                                  pic_time: 0,
                                  solo_time: 18_000,
                                  cross_country_time: 3600,
                                  night_time: 0,
                                  dual_time: 90_000,
                                  dual_crosss_country_time: 10_800,
                                  dual_night_time: 3600,
                                  hood_time: 3600,
                                  instrument_time: 0,
                                  simulator_time: 0,
                                  instructor_time: 0,
                                  number_of_stall_recovery: 3)

user = User.find_by(email: "example@railstutorial.org")
date = Date.new(2022, 02, 10)
user.create_glider_initial_log(date: date,
                              non_power_total_time: 67_680,
                              non_power_total_number: 188,
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
                              power_total_time: 0,
                              power_total_number: 0,
                              pic_power_time: 0,
                              pic_power_number: 0,
                              pic_power_off_time: 0,
                              pic_power_off_number: 0,
                              solo_power_time: 0,
                              solo_power_number: 0,
                              solo_power_off_time: 0,
                              solo_power_off_number: 0,
                              dual_power_time: 0,
                              dual_power_number: 0,
                              dual_power_off_time: 0,
                              dual_power_off_number: 0,
                              cross_country_time: 0,
                              instructor_time: 0,
                              instructor_number: 0,
                              number_of_stall_recovery: 3)

user = User.find_by(email: "example@railstutorial.org")
3.times do |n|
  n += 1
  group = Group.new(name: "テストグループ#{n}", introduction: "これはグループ#{n}の紹介文です。字数制限は今のところありません。", privacy: "プライベート")
  group.users << user if group.save
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
takeoff_time = Time.new(2022,2,21,21,0,0)
group.glider_group_flights.create(day_flight_number: nil,
                                date: date,
                                departure_and_arrival_point: '宝珠花滑空場',
                                is_winch: false,
                                fleet: 1,
                                front_seat: 100,
                                front_flight_role: '同乗教育',
                                rear_seat: 1,
                                rear_flight_role: '教官',
                                takeoff_time: takeoff_time,
                                release_time: takeoff_time + 1.minutes,
                                landing_time: takeoff_time + 12.minutes,
                                release_alt: 400,
                                notes: '備考欄です')
group = Group.find(1)
date = Date.new(2022, 2, 21)
takeoff_time = Time.new(2022,2,21,21,20,0)
group.glider_group_flights.create(day_flight_number: nil,
                                date: date,
                                departure_and_arrival_point: '宝珠花滑空場',
                                is_winch: false,
                                fleet: 1,
                                front_seat: 99,
                                front_flight_role: '同乗教育',
                                rear_seat: 1,
                                rear_flight_role: '教官',
                                takeoff_time: takeoff_time,
                                release_time: takeoff_time + 1.minutes,
                                landing_time: takeoff_time + 12.minutes,
                                release_alt: 400,
                                notes: '備考欄です')
