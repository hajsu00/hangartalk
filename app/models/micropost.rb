class Micropost < ApplicationRecord
  belongs_to :user
  has_many :glider_flight, through: :glider_micropost_relationships
  has_many :glider_micropost_relationships, dependent: :destroy
  has_many_attached :images
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :images,   content_type: { in: %w[image/jpeg image/gif image/png], message: "must be a valid image format" },
                      size: { less_than: 5.megabytes, message: "should be less than 5MB" }
  # 表示用のリサイズ済み画像を返す
  # def display_image
  #   image.variant(resize_to_limit: [500, 500])
  # end
  def display_image
    self.images.each do |image|
      image.variant(resize_to_limit: [500, 500])
    end
    images
  end
end
