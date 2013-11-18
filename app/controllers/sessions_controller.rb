class SessionsController < ApplicationController
  before_action :root_if_logged, only: [:new, :create]

  def new
    render layout: false
  end

  def create
    user = login(params[:username], params[:password], params[:remember_me])
    if user
      render layout: false
    else
      render json: {msg: 'Username or password was invalid'}, status: 400
    end
  end

  def destroy
    logout
    redirect_to root_url
  end


  private
  def root_if_logged
    redirect_to root_url if logged_in?
  end
end
