class StaticPagesController < ApplicationController
  before_action :set_sideber_data, if: :user_signed_in?
  def top
    @microposts = Micropost.where("is_flight_attached = ?", true).limit(10).order(:created_at).includes(                 [:images_attachments,
      :like_relationships,
      :replying,
      :replied,
      :sharing,
      :shared,
      :gliderflight, { replying: :replying_relationships, replied: :replied_relationships, sharing: :sharing_relationships, shared: :shared_relationships, gliderflight: :gliderflight_microposts }])
    # @microposts = Micropost.where("is_flight_attached = ?", true).limit(10).order(:created_at)
  end

  def about
  end

  def faq
  end

  def inquiry
  end

  def policy
  end
end
