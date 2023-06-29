class GroupUsersController < ApplicationController
  before_action :set_group

  def index
    @group_users = @group.group_users
  end

  def destroy
    if @group.group_users.count == 1
      @group.destroy
    else
      @group_user = @group.group_users.find(params[:user_id])
      @group_user.destroy
    end
    redirect_to root_path
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end
end
