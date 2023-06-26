class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.save
    redirect_to @group
  end

  def show
    @group = Group.find(params[:id])
    @group_users = @group.group_users
    @links = @group.links
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path
  end
end
