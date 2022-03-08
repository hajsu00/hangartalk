class ShareRelationshipsController < ApplicationController
  def create
    @shared_micropost = Micropost.find(params[:shared_id])
    @sharing_micropost = current_user.microposts.new(content: nil, is_flight_attached: false, is_sharing_micropost: true, images: [])
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

  end

  private

  # def shared_micropost_params
  #   params.require(:micropost).permit(:content, :is_flight_attached, :is_sharing_micropost, images: [])
  # end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
