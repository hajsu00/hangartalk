class LikeRelationshipsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  def create
    @micropost = Micropost.find(params[:id])
    @micropost.like_relationships.create!(user_id: current_user.id)
    redirect_to request.referrer || root_url
  end

  def destroy
    @like_rekationship.destroy
    redirect_to request.referrer || root_url
  end

  private

  def correct_user
    @like_rekationship = LikeRelationship.find_by(micropost_id: params[:id], user_id: current_user.id)
    redirect_to root_url if @like_rekationship.nil?
  end
end
