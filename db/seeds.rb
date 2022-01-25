# メインのサンプルユーザーを1人作成する
User.create!(name: "Example User", email: "example@railstutorial.org", password: "foobar", password_confirmation: "foobar", admin: true, activated: true, activated_at: Time.zone.now)

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
user = User.find_by(id: 1)
23.times do |n|
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
                              is_pic: true,
                              is_dual: false,
                              is_cross_country: true,
                              is_night_flight: true,
                              is_hood: false,
                              is_instrument: false,
                              is_simulator: false,
                              is_instructor: true,
                              is_stall_recovery: false,
                              note: '備考欄です。')
  # users.each { |user| user.aeroplane_flights.create!(log_number: n + 1, departure_date: departure_date, aeroplane_type: 'ask21', aeroplane_ident: 'ja21ma', moving_time: moving_time, stop_time: stop_time, is_pic: true, is_cross_country: false, is_instructor: false, note: 'テストテスト') }
end
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
