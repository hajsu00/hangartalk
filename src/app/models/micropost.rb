class Micropost < ApplicationRecord
  belongs_to :user
  # 返信機能
  has_many :replying_relationships, class_name: 'ReplyRelationship',
                                    foreign_key: 'replying_id',
                                    dependent: :destroy
  has_many :replied_relationships, class_name: 'ReplyRelationship',
                                   foreign_key: 'replied_id',
                                   dependent: :destroy
  has_many :replying, through: :replying_relationships
  has_many :replied, through: :replied_relationships
  # シェア機能
  has_one :sharing_relationships, class_name: 'ShareRelationship',
                                  foreign_key: 'sharing_id',
                                  dependent: :destroy
  has_many :shared_relationships, class_name: 'ShareRelationship',
                                  foreign_key: 'shared_id',
                                  dependent: :destroy
  has_one :sharing, through: :sharing_relationships
  has_many :shared, through: :shared_relationships
  # いいね！機能
  has_many :like_relationships, dependent: :destroy
  # フライト投稿機能（グライダー）
  has_many :glider_micropost_relationships, dependent: :destroy
  has_many :glider_flight, through: :glider_micropost_relationships
  # 画像投稿
  has_many_attached :images
  # バリデーション
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }, unless: :is_sharing_micropost?
  validates :images, content_type: { in: %w[image/jpeg image/gif image/png], message: "must be a valid image format" },
                     size: { less_than: 5.megabytes, message: "画像サイズの最大値は５MBです" }

  def display_image
    self.images.each do |image|
      image.variant(resize_to_limit: [500, 500])
    end
    images
  end

  def replying_micropost?
    reply_relationship = ReplyRelationship.find_by(replying_id: self.id)
    reply_relationship.nil? ? false : true
  end

  def get_replied_microposts
    reply_relationships = ReplyRelationship.where("replying_id = ?", self.id)
    replied_microposts = []
    reply_relationships.each do |reply_relationship|
      replied_microposts << Micropost.find(reply_relationship.replied_id)
    end
    replied_microposts
  end

  def get_shared_micropost
    share_relationship = ShareRelationship.find_by(sharing_id: self.id)
    share_relationship.nil? ? nil : Micropost.find(share_relationship.shared_id)
  end

  def number_of_replied
    ReplyRelationship.where("replied_id = ?", self.id).count
  end

  def number_of_shared
    ShareRelationship.where("shared_id = ?", self.id).count
  end

  def number_of_liked
    LikeRelationship.where("micropost_id = ?", self.id).count
  end

  def is_shared_by_current_user?(user)
    share_relationships = ShareRelationship.where("shared_id = ?", self.id)
    current_user_micropost_ids = user.microposts.ids
    share_relationships.each do |share_relationship|
      return true if current_user_micropost_ids.include?(share_relationship.sharing_id)
    end
    false
  end

  def is_liked_by_current_user?(user)
    liking_users_ids = LikeRelationship.where("micropost_id = ?", self.id).pluck(:user_id)
    liking_users_ids.include?(user.id) ? true : false
  end

  def is_sharing_micropost?
    self.is_sharing_micropost ? true : false
  end
end
