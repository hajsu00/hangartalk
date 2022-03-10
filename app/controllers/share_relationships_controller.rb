class ShareRelationshipsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  def create
    @shared_micropost = Micropost.find(params[:shared_id])
    @sharing_micropost = current_user.microposts.new(content: '引用リツイート', is_flight_attached: false, is_sharing_micropost: true, images: [])
    if @sharing_micropost.save
      @sharing_micropost.create_sharing_relationships!(shared_id: @shared_micropost.id)
      flash[:success] = "投稿をシェアしました！"
      redirect_to request.referrer || root_url
    else
      @microposts = current_user.feed
      redirect_to request.referrer || root_url
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
    @share_relationships = ShareRelationship.where("shared_id = ?", params[:id])
    @share_relationships.each do |share_relationship|
      @sharing_micropost = Micropost.find_by(id: share_relationship.sharing_id)
      break if current_user.microposts.include?(@sharing_micropost)
    end
    redirect_to root_url if @sharing_micropost.nil?
  end
end
