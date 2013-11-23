class UsersController < ApplicationController
  authorize_resource

  def show
    @user = User.find params[:id]
    @bubble_color = @user.bubble_color
    render layout: false
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes update_user_params
      render text: '更新成功'
    else
      render text: @user.errors.full_messages.join('<br />'), status: 400
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to root_url
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :bubble_color)
  end

  def update_user_params
    _params = params.require(:user).permit(:email, :password, :password_confirmation, :bubble_color)
    if _params[:password].blank? or _params[:password_confirmation].blank?
      _params.delete :password
      _params.delete :password_confirmation
    end
    _params
  end
end
