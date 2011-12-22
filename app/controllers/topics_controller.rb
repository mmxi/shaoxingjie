class TopicsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update]
  before_filter :find_forum, :only => [:create]

  add_breadcrumb I18n.t("breadcrumbs.forum"), :topics_path

  def index
    @topics = Topic.limit(50)#.includes(:forum, :user)
  end

  def new
    @topic = current_user.topics.new
    render :layout => "simple"
  end

  def create
    @topic = current_user.topics.new(params[:topic])
    @topic.forum = @forum
    if @topic.save
      redirect_to topics_path
    else
      render :action => :new, :layout => "simple"
    end
  end

  def tforum
  end

  protected
    def find_forum
      @forum = Forum.find_by_num(params[:topic][:forum_id])
    end
end
