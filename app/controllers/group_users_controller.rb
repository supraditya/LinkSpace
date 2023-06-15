class GroupUsersController < ApplicationController
  before_action :set_group

  def index
    @group_users = @group.group_users
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end
end
