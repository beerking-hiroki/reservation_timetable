class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :require_login
  helper_method :current_store

  def current_store
    @current_store ||= Store.find_by(id: session[:store_id])
  end

  private
  
  def require_login
    redirect_to login_path unless current_store
  end
end
