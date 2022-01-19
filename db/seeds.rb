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
users = User.order(:created_at).take(6)
10.times do |n|
  departure_date = Time.zone.today
  takeoff_time = Time.current
  moving_time = takeoff_time - 6.minutes
  landing_time = takeoff_time + 10.minutes * (n + 1)
  stop_time = landing_time + 6.minutes
  users.each { |user| user.aeroplane_flights.create!(departure_date: departure_date, aeroplane_type: 'ask21', aeroplane_ident: 'ja21ma', moving_time: moving_time, stop_time: stop_time) }
end
