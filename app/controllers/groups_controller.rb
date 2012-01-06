class GroupsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :join, :leave, :new_topic, :create_topic]
  add_breadcrumb I18n.t("breadcrumbs.group"), :groups_path
  include_kindeditor :only => [:new_topic, :create_topic]
  
  def index
    @groups = Group.page(params[:page]).per(20).desc(:members_count)
    @newest_groups = Group.all.limit(10).desc(:created_at)
  end
  
  def show
    @group = Group.find_by_num(params[:id])
    if !@group
      redirect_to groups_path
    else
      add_breadcrumb @group.title, group_path(@group)
      @newest_users = @group.members.limit(8)
      @topics = @group.topics.page(params[:page]).per(30).desc(:created_at)
    end
  end
  
  def new
    @group = Group.new
    render :layout => "simple"
  end
  
  def create
    @group = current_user.create_group(params[:group])
    if @group.save
      redirect_to @group
    else
      render :action => :new, :layout => "simple"
    end
  end
  
  def edit
    @group = Group.find_by_num(params[:id])
    render :layout => "simple"
  end
  
  def update
    @group = Group.find_by_num(params[:id])
    if @group
      if @group.update_attributes(params[:group])
        redirect_to @group
      else
        render :action => :edit, :layout => "simple"
      end
    end
  end
  
  def join
    @group = Group.find_by_num(params[:id])
    respond_to do |format|
      format.html do
        current_user.become_member_of(@group)
        redirect_to @group
      end
      format.js
    end
  end
  
  def leave
    @group = Group.find_by_num(params[:id])
    current_user.leave(@group)
    redirect_to @group
  end
  
  def new_topic
    @group = Group.find_by_num(params[:id])
    if !!@group
      add_breadcrumb I18n.t("breadcrumbs.new_topic"), new_topic_group_path(params[:id])
      @topic = Topic.new
      render :layout => "simple"
    else
      redirect_to groups_path
    end
  end
  
  def create_topic
    @group = Group.find_by_num(params[:id])
    @topic = current_user.create_topic(params[:topic], @group)
    if @topic.save
      redirect_to topic_path(@topic)
    else
      render :action => :new_topic
    end
  end
  
  def my_group
    
  end
  
  def tags
    
  end
  
  def tag
    render :text => params[:tid]
  end
  
  def group_user
    
  end
end
