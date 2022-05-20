class StaticPagesController < ApplicationController
  before_action :set_sideber_data, if: :user_signed_in?
  # def top
  #   if logged_in?
  #     @micropost  = current_user.microposts.build
  #     @microposts = current_user.feed.order(created_at: :desc).page(params[:page]).per(10)
  #   end
  # end

  def about
  end

  def faq
  end

  def inquiry
  end

  def policy
  end
end
