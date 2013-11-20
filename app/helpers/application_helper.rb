module ApplicationHelper
  def root?
    logged_in? && current_user.root?
  end
end
