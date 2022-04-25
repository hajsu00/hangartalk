class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :set_sideber_data, only: [:show, :index, :show_reply_form]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "マイクロポストを投稿しました！"
      redirect_to microposts_url
    else
      # @microposts = current_user.feed
      redirect_to microposts_url
    end
  end

  def show
    @target_micropost = Micropost.find(params[:id])
    @user = @target_micropost.user
    @replying_relationships = ReplyRelationship.where("replied_id = ?", @target_micropost.id)
    @replying_microposts = []
    @replying_relationships.each do |replying_relationship|
      @replying_microposts << Micropost.find(replying_relationship.replying_id)
    end
    replied_relationships = ReplyRelationship.find_by(replying_id: @target_micropost.id)
    @replied_micropost = Micropost.find(replied_relationships.replied_id) if !replied_relationships.nil?
    @micropost = Micropost.new
  end

  def create_reply
    @replying_micropost = current_user.microposts.build(reply_params)
    if @replying_micropost.save && @replying_micropost.replying_relationships.create!(replied_id: params[:micropost_id])
      flash[:success] = "マイクロポストを投稿しました！"
      redirect_to microposts_url
    else
      @microposts = current_user.feed
      redirect_to microposts_url
    end
  end

  def share_flight
    @micropost = current_user.microposts.build(sharing_flight_params)
    if @micropost.save && @micropost.glider_micropost_relationships.create!(glider_flight_id: params[:micropost][:glider_flight_id])
      flash[:success] = "フライトをシェアしました！"
      redirect_to microposts_url
    else
      @microposts = current_user.feed
      redirect_to microposts_url
    end
  end

  def index
    @microposts = @current_user.feed.order(created_at: :desc).includes([:like_relationships, replying: :replying_relationships, replied: :replied_relationships, sharing: :sharing_relationships, shared: :shared_relationships, glider_flight: :glider_micropost_relationships]).page(params[:page]).per(10)
    @reccomended_users = User.where.not("id = ?", @current_user.id) - @current_user.following
  end

  def destroy
    @micropost.destroy
    flash[:success] = "マイクロポストを削除しました。"
    redirect_to request.referrer || microposts_url
  end

  private

  def micropost_params
    params.permit(:content, :is_flight_attached, images: [])
  end

  def reply_params
    params.require(:micropost).permit(:content, :is_flight_attached, images: [])
  end

  def sharing_flight_params
    params.require(:micropost).permit(:content, :is_flight_attached, images: [])
  end

  def shared_flight_params
    params.require(:micropost).permit(:glider_flight_id)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
