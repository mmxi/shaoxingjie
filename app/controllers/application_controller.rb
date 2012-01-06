class ApplicationController < ActionController::Base
  protect_from_forgery

  add_breadcrumb I18n.t("breadcrumbs.home"), :root_path

  def authenticate_user!(return_point = request.url)
    unless user_signed_in?
      respond_to do |format|
        format.html { redirect_to new_user_session_path }
        format.js
      end
    end
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
end
