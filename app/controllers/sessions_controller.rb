class SessionsController < ApplicationController

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
end
