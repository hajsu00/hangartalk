class Micropost < ApplicationRecord
  belongs_to :user
  # 返信機能
  has_many :replying_relationships, class_name: 'ReplyRelationship',
                                   foreign_key: 'replying_id',
                                   dependent: :destroy
  has_one :replied_relationships, class_name: 'ReplyRelationship',
                                  foreign_key: 'replied_id',
                                  dependent: :destroy
  has_many :replying, through: :replying_relationships
  has_one :replied, through: :replied_relationships
  # フライト投稿機能（グライダー）
  has_many :glider_flight, through: :glider_micropost_relationships
  has_many :glider_micropost_relationships, dependent: :destroy
  # 画像投稿
  has_many_attached :images
  #バリデーション
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :images,   content_type: { in: %w[image/jpeg image/gif image/png], message: "must be a valid image format" },
                      size: { less_than: 5.megabytes, message: "should be less than 5MB" }
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

  def replied_user_name
    replied_micropost.user.name
  end

  def replied_user_id
    replied_micropost.user.id
  end

  def replied_micropost
    reply_relationship = ReplyRelationship.find_by(replying_id: self.id)
    Micropost.find(reply_relationship.replied_id)
  end

  def number_of_replied
    ReplyRelationship.where("replied_id = ?", self.id).count
  end

  # def reply(target_micropost)
  #   replying << target_micropost
  # end
end
