class Admin::ApplicationController < ApplicationController
  layout "admin"
  before_filter :authenticate_user!
  check_authorization

  def current_ability
    @current_ability ||= AdminAbility.new(current_user)
  end
end
