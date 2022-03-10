class ShareRelationshipsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  def create
    @shared_micropost = Micropost.find(params[:shared_id])
    @sharing_micropost = current_user.microposts.new(content: '引用リツイート', is_flight_attached: false, is_sharing_micropost: true, images: [])
    if @sharing_micropost.save
      # 返信用のマイクロポストの場合は返信先とのリレーションを中間テーブルに保存
      @sharing_micropost.create_sharing_relationships!(shared_id: @shared_micropost.id)
      flash[:success] = "投稿をシェアしました！"
      redirect_to root_url
    else
      @microposts = current_user.feed
      render 'static_pages/top'
    end
  end

  def destroy
    @sharing_micropost.destroy
    redirect_to request.referrer || root_url
  end

  private

  # def shared_micropost_params
  #   params.require(:micropost).permit(:content, :is_flight_attached, :is_sharing_micropost, images: [])
  # end

  def correct_user
    @sharing_microposts = ShareRelationship.where("shared_id = ?", params[:id])
    @sharing_microposts.each do |sharing_micropost|
      @sharing_micropost = Micropost.find_by(id: sharing_micropost.sharing_id)
      break if current_user.microposts.include?(@sharing_micropost)
    end
    redirect_to root_url if @sharing_micropost.nil?
  end
end
