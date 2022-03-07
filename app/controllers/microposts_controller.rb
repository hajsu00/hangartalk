class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      if !params[:micropost][:glider_flight_id].nil?
        @micropost.glider_micropost_relationships.create!(glider_micropost_relationship_params)
      end
      if !params[:micropost][:replied_micropost].nil?
        replied_microposts = reply_relationship_params[:replied_micropost].map do |replied_micropost|
          JSON.parse(replied_micropost)
        end
        replied_microposts[0].each_with_index do |replied_micropost, i|
          @micropost.replying_relationships.create!(replied_id: replied_micropost["id"])
        end
      end
      flash[:success] = "マイクロポストを投稿しました！"
      redirect_to root_url
    else
      @microposts = current_user.feed
      render 'static_pages/top'
    end
  end

  def show
    @replied_micropost = []
    @replied_micropost << Micropost.find(params[:id])
    replying_micropost_ids = ReplyRelationship.where("replying_id = ?", @replied_micropost[0][:id]).pluck(:replied_id)
    replying_micropost_ids.each do |replying_micropost_id|
      if @replied_micropost[0][:id] != replying_micropost_id
        @replied_micropost << Micropost.find(replying_micropost_id)
      end
    end
    # binding.pry
    # @replying_micropost_ids = ReplyRelationship.where("replied_id = ?", @replied_micropost.id).pluck(:replying_id)
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
    params.require(:micropost).permit(replied_micropost: [])
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
