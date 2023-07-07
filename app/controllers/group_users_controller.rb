class GroupUsersController < ApplicationController
  before_action :set_group

  def index
    @group_users = @group.group_users
  end

  def destroy
    @group_user = @group.group_users.find(params[:id])

    if @group.group_users.count == 1
      @group.destroy
      redirect_to root_path
    else
      @group_user.destroy
      redirect_to @group
    end
  end

  def new
    @group_user = @group.group_users.new
  end

  def create
    @user = User.find_by(email: group_user_params[:email])

    if @user
      if @group.group_users.where(user_id: @user.id).exists?
        @group_user = @group.group_users.new
        render :new, status: :unprocessable_entity
        return
      end

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
        render :new, status: :unprocessable_entity
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
