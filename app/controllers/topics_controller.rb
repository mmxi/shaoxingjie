class TopicsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update]
  before_filter :find_forum, :only => [:create]
  include_kindeditor :only => [:show]

  add_breadcrumb I18n.t("breadcrumbs.group"), :groups_path

  def index
    @topics = Topic.limit(50).includes(:group, :user).desc(:created_at)
    add_breadcrumb I18n.t("breadcrumbs.recent_topics"), topics_path
  end

  def show
    @topic = Topic.find_by_num(params[:id])
    @reply = Reply.new
    add_breadcrumb @topic.group.title, group_path(@topic.group)
    add_breadcrumb @topic.title, topic_path(@topic)
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
