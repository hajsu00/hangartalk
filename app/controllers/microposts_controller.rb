class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      if !params[:micropost][:glider_flight_id].nil?
        # 「フライトログブック」→「フライトの詳細（glider_flightモデルのshowページ）」→「シェア」ボタン押下によるマイクロポスト投稿時の処理
        @micropost.glider_micropost_relationships.create!(glider_micropost_relationship_params)
      end
      flash[:success] = "マイクロポストを投稿しました！"
      redirect_to root_url
    else
      @microposts = current_user.feed
      render 'static_pages/top'
    end
  end

  def destroy
    @glider_micropost = GliderMicropostRelationship.find_by(micropost_id: @micropost.id)
    @micropost.destroy
    flash[:success] = "マイクロポストを削除しました。"
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :is_flight_attached, :image)
  end

  def glider_micropost_relationship_params
    params.require(:micropost).permit(:glider_flight_id)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
