class Admin::ForumsController < Admin::ApplicationController
  authorize_resource
  before_filter :find_forum

  def index
    @forums = Forum.sorted
  end

  def new
    @forum = Forum.new
  end

  def create
    @forum = Forum.new(params[:forum])
    if @forum.save
      redirect_to admin_forums_url, :notice => "Forum was successfully created."
    else
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @forum.update_attributes(params[:forum])
      redirect_to admin_forums_url, :notice => "Forum was successfully updated."
    else
      render :action => :edit
    end
  end

  def destroy
    @forum.destroy
    redirect_to admin_forums_url
  end

  protected
    def find_forum
      @forum = Forum.find_by_num(params[:id])
    end
end
