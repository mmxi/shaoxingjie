class Admin::GroupsController < Admin::ApplicationController
  authorize_resource
  def index
    @groups = Group.page(params[:page]).per(5).desc(:created_at)
  end
  
  def new
    @group = Group.new
  end
  
  def create
    @group = current_user.create_group(params[:group])
    @group.verified = params[:group][:verified]
    @group.allowadduser = params[:group][:allowadduser]
    if @group.save
      redirect_to admin_groups_path, :notice => "Group was successfully created."
    else
      render :action => :new
    end
  end
  
  def edit
    @group = Group.find_by_num(params[:id])
  end
  
  def update
    @group = Group.find_by_num(params[:id])
    @group.accessible = :all if current_user.role?(:admin)
    if @group
      if @group.update_attributes(params[:group])
        #flash[:notice] = "Update success"
        redirect_to edit_admin_group_path(@group), :notice => "Group was successfully updated."
      else
        render :action => :edit
      end
    end
  end
  
  def search
     @groups = Group.search(params[:keyword]).page(params[:page]).per(5).desc(:created_at)
     render :template => "admin/groups/index"
  end
end