class StaticPagesController < ApplicationController
  def top
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed
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
