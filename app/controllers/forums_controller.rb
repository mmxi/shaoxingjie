class ForumsController < ApplicationController
  before_filter

  add_breadcrumb I18n.t("breadcrumbs.forum"), :forums_path

  def index
    @forums = Forum.all()
    render :json => @forums, :only => [:name]
  end

  def show
    @forums = Forum.find(params[:id])
  end
end
