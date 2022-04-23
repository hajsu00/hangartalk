class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :set_sideber_data, only: [:show, :index, :show_reply_form]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      # フライト情報の有無を確認
      if !params[:micropost][:glider_flight_id].nil?
        @micropost.glider_micropost_relationships.create!(glider_micropost_relationship_params)
      end
      # 返信用のマイクロポストの場合は返信先とのリレーションを中間テーブルに保存
      if !params[:micropost][:replied_micropost].nil?
        replied_microposts = reply_relationship_params[:replied_micropost].map do |replied_micropost|
          JSON.parse(replied_micropost)
        end
        replied_microposts[0].each_with_index do |replied_micropost, i|
          @micropost.replying_relationships.create!(replied_id: replied_micropost["id"])
        end
      end
      flash[:success] = "マイクロポストを投稿しました！"
      redirect_to microposts_url
    else
      @microposts = current_user.feed
      render 'static_pages/top'
    end
  end

  def show
    @replied_micropost = Micropost.find(params[:id])
    @user = @replied_micropost.user
    @replying_relationships = ReplyRelationship.where("replied_id = ?", @replied_micropost.id)
    @replying_microposts = []
    @replying_relationships.each do |replying_relationship|
      @replying_microposts << Micropost.find(replying_relationship.replying_id)
    end
    @micropost = Micropost.new
  end

  def create_reply
    @replying_micropost = current_user.microposts.build(micropost_params)
    if @replying_micropost.save && @replying_micropost.replying_relationships.create!(replied_id: params[:micropost_id])
      flash[:success] = "マイクロポストを投稿しました！"
      redirect_to user_microposts_url
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
    @glider_micropost = GliderMicropostRelationship.find_by(micropost_id: @micropost.id)
    @replying_relationship = ReplyRelationship.find_by(replying_id: @micropost.id)
    @replied_relationship = ReplyRelationship.find_by(replied_id: @micropost.id)
    @shared_relationship = ShareRelationship.find_by(shared_id: @micropost.id)
    @sharing_relationship = ShareRelationship.find_by(sharing_id: @micropost.id)
    @micropost.destroy
    @glider_micropost.destroy if !@glider_micropost.nil?
    @replying_relationship.destroy if !@replying_relationship.nil?
    @replied_relationship.destroy if !@replied_relationship.nil?
    @shared_relationship.destroy if !@shared_relationship.nil?
    @sharing_relationship.destroy if !@sharing_relationship.nil?
    flash[:success] = "マイクロポストを削除しました。"
    redirect_to request.referrer || microposts_url
  end

  def share_micropost
    @micropost = Micropost.find(params[:id])
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :is_flight_attached, images: [])
  end

  def glider_micropost_relationship_params
    params.require(:micropost).permit(:glider_flight_id)
  end

  def reply_relationship_params
    params.require(:micropost).permit(replied_micropost: [])
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
