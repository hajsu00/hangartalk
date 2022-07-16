class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :set_sideber_data, only: [:show, :index, :show_reply_form]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "マイクロポストを投稿しました！"
    else
      # @microposts = current_user.feed
    end
    redirect_to microposts_url
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
    @replied_micropost = Micropost.find(replied_relationships.replied_id) unless replied_relationships.nil?
    @micropost = Micropost.new
  end

  def create_reply
    @replying_micropost = current_user.microposts.build(reply_params)
    if @replying_micropost.save && @replying_micropost.replying_relationships.create!(replied_id: params[:micropost_id])
      flash[:success] = "フライトをシェアしました！"
    else
      @microposts = current_user.feed
    end
    redirect_to microposts_url
  end

  def share_flight
    @micropost = current_user.microposts.build(sharing_flight_params)
    if @micropost.save && @micropost.gliderflight_microposts.create!(gliderflight_id: params[:micropost][:gliderflight_id])
      flash[:success] = "フライトをシェアしました！"
    else
      @microposts = current_user.feed
    end
    redirect_to microposts_url
  end

  def index
    @microposts = @current_user.feed.order(created_at: :desc).includes(                 [:images_attachments,
                                                                        :like_relationships,
                                                                        :replying,
                                                                        :replied,
                                                                        :sharing,
                                                                        :shared,
                                                                        :gliderflight, { replying: :replying_relationships, replied: :replied_relationships, sharing: :sharing_relationships, shared: :shared_relationships, gliderflight: :gliderflight_microposts }]).page(params[:page]).per(10)
    @reccomended_users = User.where.not("id = ?", @current_user.id).includes([:avatar_attachment, :user_cover_attachment]) - @current_user.following
  end

  def destroy
    # @micropost.destroy
    # flash[:success] = "マイクロポストを削除しました。"
    # redirect_to request.referer || microposts_url

    if @micropost.images.attached?
      if @micropost.images.purge_later && @micropost.destroy
        flash[:success] = "マイクロポストを削除しました。"
        redirect_to request.referer || microposts_url
      else
        flash[:success] = "マイクロポストの削除中にエラーが発生しました。"
        render microposts_url
      end
    else
      if @micropost.destroy
        flash[:success] = "マイクロポストを削除しました。"
        redirect_to request.referer || microposts_url
      else
        flash[:success] = "マイクロポストの削除中にエラーが発生しました。"
        render microposts_url
      end
    end
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
    params.require(:micropost).permit(:gliderflight_id)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
