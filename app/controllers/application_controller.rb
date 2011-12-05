class ApplicationController < ActionController::Base
  protect_from_forgery

  add_breadcrumb I18n.t("breadcrumbs.home"), :root_path

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
end
