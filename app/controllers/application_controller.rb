class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def not_authenticated
    render file: "#{Rails.root}/public/403.html", status: 403, layout: false
  end

  protected
  def require_root
    unless logged_in? && current_user.root?
      session[:return_to_url] = request.url if Config.save_return_to_url && request.get?
      self.send(Config.not_authenticated_action)
    end
  end
end
