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

  def new
    @group_user = @group.group_users.new
  end

  def create
    @user = User.find_by(email: group_user_params[:email])

    if @user
      @group_user = @group.group_users.new(user: @user, admin: group_user_params[:admin])
      if @group_user.save
        redirect_to @group
      else
        render :new
      end
    else
      @user = User.invite!({ email: group_user_params[:email] }, current_user)
      @group_user = @group.group_users.new(user: @user, admin: group_user_params[:admin])
      if @group_user.save
        redirect_to @group
      else
        render :new
      end
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def group_user_params
    params.require(:group_user).permit(:email, :admin)
  end
end
