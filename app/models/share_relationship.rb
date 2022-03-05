class ShareRelationship < ApplicationRecord
  belongs_to :main_tweet, class_name: 'Micropost'
  belongs_to :share_tweet, class_name: 'Micropost'
end
