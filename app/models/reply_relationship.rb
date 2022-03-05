class ReplyRelationship < ApplicationRecord
  belongs_to :replying, class_name: 'Micropost', optional: true
  belongs_to :replied, class_name: 'Micropost', optional: true
  validates :replying_id, presence: true
  validates :replied_id, presence: true
end
