class RolesController < ApplicationController
  authorize_resource

  def index
    @users = User.includes(:roles).page params[:page]
  end

  def destroy
    @user = User.find params[:user_id]
    @role = @user.roles.find params[:id]
    @user.remove_role @role.name, @role.resource
    redirect_to roles_url
  end
end
