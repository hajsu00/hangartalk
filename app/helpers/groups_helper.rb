module GroupsHelper
  def current_group
    @current_group = Group.find_by(id: params[:id])
  end
end
