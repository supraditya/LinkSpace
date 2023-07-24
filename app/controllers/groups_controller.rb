class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_group_user, only: [:show]

  def index
    @group_users = GroupUser.all.where(user_id: current_user.id)
    @groups = @group_users.map(&:group)
    @links={}
    @groups.each do |group| 
      @links[group] = group.links.sort_by(&:created_at).reverse.take(3)
    end
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group_user = GroupUser.new(user_id: current_user.id, group: @group, admin: true)
    if @group.save && @group_user.save
      redirect_to @group
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    #To-do: authenticate
    @group = Group.find(params[:id])
    @group_users = @group.group_users
    @links = @group.links.map do |link|
      { link: link, metadata: link.fetch_metadata }
    end
  end

  def destroy
    #To-do: authenticate
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :description)
  end

  def authenticate_group_user
    @group = Group.find(params[:id])
    unless @group.group_users.where(user_id: current_user.id).exists?
      redirect_to groups_path
    end
  end
end
