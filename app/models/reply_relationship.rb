class ReplyRelationship < ApplicationRecord
  belongs_to :replying, class_name: 'Micropost'
  belongs_to :replied, class_name: 'Micropost'
  validates :replying_id, presence: true
  validates :replied_id, presence: true
end
