class ReplyRelationship < ApplicationRecord
  belongs_to :main_tweet, class_name: 'Micropost'
  belongs_to :reply_tweet, class_name: 'Micropost'
end
