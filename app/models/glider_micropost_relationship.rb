class GliderMicropostRelationship < ApplicationRecord
  belongs_to :micropost
  belongs_to :glider_flight
end
