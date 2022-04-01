class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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

  # before_save   :downcase_email
  # before_create :create_activation_digest
  # before_save { email.downcase! }

  # validates :name,  presence: true, length: { maximum: 50 }
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  # has_secure_password
  # validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # ookieを使いログイン情報を保持
  def remember_me
    true
  end

  # # 渡された文字列のハッシュ値を返す
  # def self.digest(string)
  #   cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
  #   BCrypt::Password.create(string, cost: cost)
  # end

  # # ランダムなトークンを返す
  # def self.new_token
  #   SecureRandom.urlsafe_base64
  # end

  # # 永続セッションのためにユーザーをデータベースに記憶する
  # def remember
  #   self.remember_token = User.new_token
  #   update_attribute(:remember_digest, User.digest(remember_token))
  # end

  # # 渡されたトークンがダイジェストと一致したらtrueを返す
  # def authenticated?(attribute, token)
  #   digest = self.send("#{attribute}_digest")
  #   return false if digest.nil?

  #   BCrypt::Password.new(digest).is_password?(token)
  # end

  # # ユーザーのログイン情報を破棄する
  # def forget
  #   update_attribute(:remember_digest, nil)
  # end

  # # アカウントを有効にする
  # def activate
  #   update_columns(activated: true, activated_at: Time.zone.now)
  # end

  # # 有効化用のメールを送信する
  # def send_activation_email
  #   UserMailer.account_activation(self).deliver_now
  # end

  # # パスワード再設定の属性を設定する
  # def create_reset_digest
  #   self.reset_token = User.new_token
  #   update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  # end

  # # パスワード再設定のメールを送信する
  # def send_password_reset_email
  #   UserMailer.password_reset(self).deliver_now
  # end

  # # パスワード再設定の期限が切れている場合はtrueを返す
  # def password_reset_expired?
  #   reset_sent_at < 1.hour.ago
  # end

  # ユーザーのステータスフィードを返す
  def feed
    following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    # Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
    Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id).includes([:like_relationships, replying: :replying_relationships, replied: :replied_relationships, sharing: :sharing_relationships, shared: :shared_relationships, glider_flight: :glider_micropost_relationships])
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
    true if !any_group.nil?
  end

  # private

  # # メールアドレスをすべて小文字にする
  # def downcase_email
  #   self.email = email.downcase
  # end
  # # 有効化トークンとダイジェストを作成および代入する
  # def create_activation_digest
  #   self.activation_token  = User.new_token
  #   self.activation_digest = User.digest(activation_token)
  # end
end
