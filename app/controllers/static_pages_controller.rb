class StaticPagesController < ApplicationController
  def top
    if logged_in?
      binding.pry
      @micropost  = current_user.microposts.build
      @microposts = current_user.feed.order(created_at: :desc).page(params[:page]).per(10)
    end
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
