class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :glider_group_flights, dependent: :destroy
  has_many :fleets, dependent: :destroy
  has_one_attached :group_cover

  validates :name, presence: true

  # ユーザーをメンバーに加える
  def join(target_user)
    users << target_user
  end

  # ユーザーを退会させる
  def leave(target_user)
    group_users.find_by(user_id: target_user.id).destroy
  end
end
