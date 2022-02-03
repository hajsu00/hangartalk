class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users, dependent: :destroy
  has_many :glider_group_flights, dependent: :destroy
  validates :name, presence: true
end
