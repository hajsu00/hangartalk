class GroupUsersController < ApplicationController
  before_action :logged_in_user

  def create
    @current_group = Group.find(params[:group_id])
    @current_group.join(current_user)
    respond_to do |format|
      format.html { request.referrer || root_url }
      format.js
    end
  end

  def destroy
    @group_user = GroupUser.find(params[:id])
    @current_group = Group.find(@group_user.group_id)
    @current_group.leave(current_user)
    respond_to do |format|
      format.html { request.referrer || root_url }
      format.js
    end
  end
end
