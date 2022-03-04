class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      # if !params[:micropost][:glider_flight_id].nil?
      #   @micropost.glider_micropost_relationships.create!(glider_micropost_relationship_params)
      # end
      # if !params[:micropost][:replied_id].nil?
      #   @micropost.replying_relationships.create!(reply_relationship_params)
      # end
        @micropost.glider_micropost_relationships.create!(glider_micropost_relationship_params) if !params[:micropost][:glider_flight_id].nil?
        @micropost.replying_relationships.create!(reply_relationship_params) if !params[:micropost][:replied_id].nil?
      flash[:success] = "マイクロポストを投稿しました！"
      redirect_to root_url
    else
      @microposts = current_user.feed
      render 'static_pages/top'
    end
  end

  def show
    @replied_micropost = Micropost.find(params[:id])
    @micropost = Micropost.new
  end

  def destroy
    @glider_micropost = GliderMicropostRelationship.find_by(micropost_id: @micropost.id)
    @replied_relationship = ReplyRelationship.find_by(replying_id: @micropost.id)
    @micropost.destroy
    @glider_micropost.destroy if !@glider_micropost.nil?
    @replied_relationship.destroy if !@replied_relationship.nil?
    flash[:success] = "マイクロポストを削除しました。"
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :is_flight_attached, images: [])
  end

  def glider_micropost_relationship_params
    params.require(:micropost).permit(:glider_flight_id)
  end

  def reply_relationship_params
    params.require(:micropost).permit(:replied_id)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
