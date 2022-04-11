class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    redirect_to @user
    # respond_to do |format|
    #   format.html { redirect_to @user }
    #   format.js
    # end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    redirect_to @user
    # respond_to do |format|
    #   format.html { redirect_to @user }
    #   format.js
    # end
  end

  # def following_index
  #   @user = User.find(params[:id])
  #   @users = @user.following.order(created_at: :desc).includes([following: :active_relationships, followers: :passive_relationships]).page(params[:page]).per(10)
  #   @glider_flights = current_user.glider_flights.order(created_at: :asc).order(log_number: :asc).page(params[:page]).per(10)
  #   render 'users/index'
  # end

  # def followers_index
  #   @user = User.find(params[:id])
  #   @users = @user.followers.order(created_at: :desc).includes([following: :active_relationships, followers: :passive_relationships]).page(params[:page]).per(10)
  #   @glider_flights = current_user.glider_flights.order(created_at: :asc).order(log_number: :asc).page(params[:page]).per(10)
  #   render 'users/index'
  # end
end
