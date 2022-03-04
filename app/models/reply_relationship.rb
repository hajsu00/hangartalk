class ReplyRelationship < ApplicationRecord
  belongs_to :main_micropost, class_name: 'Micropost', optional: true # 外部キーのバリデーションチェックを回避 https://techtechmedia.com/optional-true-rails/
  belongs_to :reply_micropost, class_name: 'Micropost', optional: true
end
