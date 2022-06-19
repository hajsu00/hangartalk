# ユーザー
# メインのサンプルユーザーを1人作成する
ActionMailer::Base.perform_deliveries = false
user = User.create!(name: "株木 達郎",
                    email: "example@railstutorial.org",
                    introduction: "WEB系エンジニアになりたい元機械系エンジニア。グライダーの操縦教員もやっている31歳です。一時期バンクーバーに社会人航空留学してました。現在の本業は通訳ですが、得意なVBAを使って自部署の業務改善も担当しています。プログラミングと英語学習、キャリアについてつぶやきます。",
                    location: "東京",
                    password: "foobar",
                    password_confirmation: "foobar",
                    admin: true,
                    confirmed_at: Time.zone.now)
user.avatar.attach(io: File.open(Rails.root.join('app/assets/images/t_kyab.jpg')), filename: 't_kyab.jpg')
user.user_cover.attach(io: File.open(Rails.root.join('app/assets/images/test/user_test_cover/user_test_cover_4.jpg')), filename: 'user_test_cover_4.jpg')

AircraftType.create!(aircraft_type: 'ASK21', category: 'glider')
AircraftType.create!(aircraft_type: 'ASK21B', category: 'glider')
AircraftType.create!(aircraft_type: 'ASK23b', category: 'glider')
AircraftType.create!(aircraft_type: 'Cessna 152', category: 'aeroplane')
AircraftType.create!(aircraft_type: 'Cessna 172', category: 'aeroplane')

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

user_bio = ["航空大学校からエアラインに就職しました。パイロット志望者を応援します。パイロットの日常も呟きます。",
            "飛行機を飛ばす練習をしています。初心を忘れず、謙虚に頑張っていきます。",
            "パイロットの夢が捨てられない31歳。2022年9月脱サラ予定。",
            "2023年卒で自社養成パイロットを志望している大学生です！ 情報を交換し合って互いに合格を支援しあえる人を探しています！",
            "パイロットを目指す24卒大学生。航大受験予定です。",
            "パイロットの仕事をしています。私大パイロットコース→某エアラインB737副操縦士→大手外資系航空会社に転職→B787副操縦士",
            "コロナが落ち着いたらカナダでエアラインを目指します。JCAB CPL IR FAA PPLを保有。",
            "パイロットを目指してます。パイロット、エアライン業界目指してる方、フォローして下さい。 22卒",
            "アメリカの自家用操縦士。パイロット職を目指して航空学校で事業用多発計器ライセンスを取得中の33歳。🇯元自動車エンジニア（元自動車メンテナンスエンジニア）。",
            "絶対パイロットになります。 22卒/自社養成/私大編入/自費/同じ志の方共に夢を掴みましょう。航空通取得済",
            "県立に通う高1で、夢はパイロットです。/ パイロット志望の人、飛行機が好きな人、 飛行機に関係してる人どんどんフォローください。",
            "将来航空業界を目指している方と情報交換ができたらなと思い、アカウントを作りました。 ANAとJALの中立派。成田＆羽田ベースです",
            "航空自衛隊の方を探してます。航空学生になりたいです。航空自衛隊の素晴らしさをこの世に広げていきたいです。",
            "パイロット志望の大学2年生です。自社養成パイロット合格と航空大学校の両方を目指して頑張っております！同じ志を持つ方は、是非フォローお願い致します！",
            "将来エアラインパイロットになりたい高校一年生ですが、まだ一度も飛行機に乗ったことがないです。空への憧れだけですが、なりたい気持ちはとても強いです。パイロット志望の方々と繋がりたいです。よろしくお願いします。",
            "パイロットを志望している高校生です。飛行機が好きな人、パイロット志望の人、航空業界の人フォローおねがいします。",
            "アメリカでフライトスクールに通っている23歳です。グリーンカードを持っています。将来はアメリカの航空会社で働くのが夢です。",
            "成り上がった外資系パイロット。下積み期間役１０年。フライトスクール教官３年、救急４年、リージョナル３年。パイロットを志す若者を応援します。"]

m = 0
17.times do |n|
  name  = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  password = "password"
  user = User.create!(name: name,
                      email: email,
                      introduction: user_bio[n],
                      location: "東京",
                      password: password,
  password_confirmation: password)
  user.avatar.attach(io: File.open(Rails.root.join("app/assets/images/test/user_test_avatar/user_test_avatar_#{n + 1}.png")), filename: "user_test_avatar_#{n + 1}.png")
  user.user_cover.attach(io: File.open(Rails.root.join("app/assets/images/test/user_test_cover/user_test_cover_#{n + 1}.jpg")), filename: "user_test_cover_#{n + 1}.jpg")
end

# ユーザーの一部を対象にマイクロポストを生成する
content = ["これから定時到着率世界No.1のOneWorldアライアンスメンバー日本航空で沖縄行ってきます！",
            "京急で目の前に座ってる人がパイロットの方で興奮気味",
            "パイロットを目指す方は本当に諦めないでほしい。本当に10年後、後悔しますよ。あれから自分は死んでるのも同然だよ。どんなことをやっても、全く身が入らない。中途半端な人生。自分が悪いだけだけど。こんな風にならないで欲しい。",
            "もしかしてグランドハンドリングとグランドスタッフって結構ギスギスしてる感じ？",
            "家から太くなった飛行機雲見つけた。FRで見たらB777の飛行機雲。飛行機雲を見せる側になれますように",
            "今日は朝から機材トラブル。無線動かないしAPUないし...せっかく朝3時に起きたのに！",
            "パイロットのドラマあると倍率跳ね上がるからなー。目指してる人にとっては迷惑な話。昔GOOD LUCK!っていうキムタク主演のドラマがあったときは倍率跳ね上がった。",
            "初めての航空身体検査やけどめっちゃ緊張してる。朝終わって今から脳波…。",
            "航大受験アカウント作りました、。目指している方々、航大生の方々、パイロットの方々よろしくお願いします！",
            "今月の月刊エアラインは買いましたか？私は毎月買っているのですが、今月はパイロット・コクピット特集なのでパイロット志望の方は購入必須ですね",
            "とりあえず自社養成目指して頑張るわ少しでも高い大学行くぞ",
            "今日は羽田で飛行機撮影。アイス食べたり、模型買ったりして楽しめました。日本のエアライン2社、コンプリート狙おうかな笑",
            "千里川土手では空港のターミナルとは違い、飛行機と同じ高さで撮影ができるので自然と迫力が生まれていますよね。
            J-AIRの太陽のアーク塗装の2機並びは結構レアじゃないでしょうか？",
            "今日、某国内大手航空会社の人と話す機会があったんだけど、話聞く限り現状はやばすぎるけど凄く前に向かってるキャリアプランを話してくれたから、航空需要回復祈ってパイロットなって飛び続けられる日が来るまで頑張ろうってめっちゃ思った。",
            "Tverで逃げ恥再放送してる。ご飯食べながら、ガッキー見られる幸せをしばらく噛みしめたい。
            ただ、おうち帰ったらガッキーが出迎えてくれるのうらやましいぃぃぃ。",
            "試し読みして、結局続きが気になってポチった。初めてフライトした時やファーストソロの時の気持ちとか思い出して、1人感傷にひたった。1人で飛ばすんじゃ無いって良い言葉だよね。https://ebookjapan.yahoo.co.jp/books/335978/A001578384/",
            "FAA Private pilot check ride合格しました！！次はmultiをがんばります",
            "今って、空港の保安検査場でモバイルバッテリーのワット数一個一個ちゃんと見るのね。検査員さん1日で色んな種類のバッテリー見てるんだろうな。大変そう。。。
            "]
users = User.all.order(id: :asc)
n = 0
users.each do |user|
  user.microposts.create!(content: content[n], is_flight_attached: false, is_sharing_micropost: false, created_at: Time.zone.now - n.minutes,
                          updated_at: Time.zone.now - n.minutes)
  n += 1
end

# 以下のリレーションシップを作成する
users = User.all
user  = users.first
following = users[2..10]
followers = users[6..17]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }


user = User.find_by(email: "example@railstutorial.org")
date = Date.today - 3.year
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

user = User.find_by(email: "example@railstutorial.org")
23.times do |n|
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
                              flight_role: '機長',
                              is_winch: true,
                              is_cross_country: false,
                              release_alt: 420,
                              is_instructor: false,
                              is_stall_recovery: false,
                              note: '備考欄です。')
  glider_flight.aircraft_type_id = 1
  glider_flight.save(validate: false)
end

user = User.find_by(email: "example@railstutorial.org")
name = ["滝川グライダークラブ",
  "東京フライトクラブ",
  "日本フライトスクール"]
introduction = ["滝川グライダークラブの公式グループページ。体験フライト受け付けています。",
                "東京フライトクラブの公式グループページ。自家用から事業用までの操縦ライセンス取得が可能です。",
                "日本フライトスクールの公式グループページ。プロパイロットの育成に主眼を置いた飛行学校です。"]
3.times do |n|
  n += 1
  group = Group.new(name: name[n - 1], introduction: introduction[n - 1], privacy: "プライベート")
  group.users << user if group.save
  group.group_cover.attach(io: File.open(Rails.root.join("app/assets/images/test/user_test_cover/user_test_cover_#{n + 1}.jpg")), filename: "user_test_cover_#{n + 1}.jpg")
end

users = User.order(created_at: :DESC).take(3)
group = Group.find(1)
users.each do |user|
  group.users << user
end

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
                                  departure_point: '宝珠花滑空場',
                                  arrival_point: '宝珠花滑空場',
                                  is_winch: true,
                                  fleet: 1,
                                  front_seat: 17,
                                  front_flight_role: '同乗教育',
                                  rear_seat: 1,
                                  rear_flight_role: '教官',
                                  takeoff_time: takeoff_time,
                                  release_time: takeoff_time + 1.minute,
                                  landing_time: takeoff_time + 12.minutes,
                                  release_alt: 400,
                                  creator: 1,
                                  note: '備考欄です')
group = Group.find(1)
date = Date.new(2022, 2, 21)
takeoff_time = Time.zone.local(2022, 2, 21, 21, 20, 0)
group.glider_group_flights.create(day_flight_number: nil,
                                  date: date,
                                  departure_point: '宝珠花滑空場',
                                  arrival_point: '宝珠花滑空場',
                                  is_winch: true,
                                  fleet: 1,
                                  front_seat: 16,
                                  front_flight_role: '同乗教育',
                                  rear_seat: 1,
                                  rear_flight_role: '教官',
                                  takeoff_time: takeoff_time,
                                  release_time: takeoff_time + 1.minute,
                                  landing_time: takeoff_time + 12.minutes,
                                  release_alt: 400,
                                  creator: 1,
                                  note: '備考欄です')
