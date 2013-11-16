class SessionsController < ApplicationController

  def new
    render layout: false
  end

  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
    else
      render json: {msg: 'Username or password was invalid'}
    end
  end

  def destroy
    logout
  end
end
