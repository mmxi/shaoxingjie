class Admin::HomeController < Admin::ApplicationController
  authorize_resource :class => false
  def index
  end
end
