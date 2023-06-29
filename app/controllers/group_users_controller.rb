class GroupUsersController < ApplicationController
  before_action :set_group

  def index
    @group_users = @group.group_users
  end

  def destroy
    @group_user = @group.group_users.find(params[:id])
    @group_user.destroy
    redirect_to root_path
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end
end
