class ShareRelationship < ApplicationRecord
  belongs_to :sharing, class_name: 'Micropost'
  belongs_to :shared, class_name: 'Micropost'
  validates :sharing_id, presence: true
  validates :shared_id, presence: true
end
