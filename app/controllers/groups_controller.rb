class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @group_users = GroupUser.all.where(user_id: current_user.id)
    @groups = @group_users.map(&:group)
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
    #To-do: authenticate
    @group = Group.find(params[:id])
    @group_users = @group.group_users
    @links = @group.links
  end

  def destroy
    #To-do: authenticate
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path
  end
end
