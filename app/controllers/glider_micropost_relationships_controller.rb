class GliderMicropostRelationshipsController < ApplicationController
  before_action :logged_in_user
  def new
    @micropost = Micropost.new
    @target_flight = GliderFlight.find(params[:id])
  end
end
