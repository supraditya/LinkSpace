class GroupUsersController < ApplicationController
  before_action :set_group
  before_action :authenticate_user!
  before_action :authenticate_group_user, only: [:index, :destroy]
  before_action :authenticate_group_user_admin, only: [:make_admin, :remove_admin, :new, :create]

  def index
    @group_users = @group.group_users
    @current_group_user = @group.group_users.find_by(user_id: current_user.id)
    @current_group_user_role = @current_group_user.admin
  end

  def destroy
    @group_user = @group.group_users.find_by(user_id: params[:id])

    if @group.group_users.count == 1
      @group.destroy
      redirect_to root_path
    else
      @group_user.destroy
      redirect_to root_path
    end
  end

  def new
    @group_user = @group.group_users.new
  end

  def create
    @user = User.find_by(email: group_user_params[:email])

    # If user already exists
    if @user
      # If the user is already part of said group
      if @group.group_users.where(user_id: @user.id).exists?
        @group_user = @group.group_users.new
        render :new, status: :unprocessable_entity
        return
      end
      # If not a part of the group, just add the existing user to the group
      @group_user = @group.group_users.new(user: @user, admin: group_user_params[:admin])
      if @group_user.save
        redirect_to @group
      else
        render :new
      end
    else
      # If the user does not exist, send an email invite
      @user = User.invite!({ email: group_user_params[:email] }, current_user)
      @group_user = @group.group_users.new(user: @user, admin: group_user_params[:admin])
      if @group_user.save
        redirect_to @group
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def make_admin
    @group_user = @group.group_users.find(params[:id])
    @group_user.admin = true
    @group_user.save
    redirect_to group_group_users_path(@group)
  end

  def remove_admin
    @group_user = @group.group_users.find(params[:id])
    @group_user.admin = false
    @group_user.save
    redirect_to group_group_users_path(@group)
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def group_user_params
    params.require(:group_user).permit(:email, :admin)
  end

  def authenticate_group_user
    unless @group.group_users.where(user_id: current_user.id).exists?
      redirect_to groups_path
    end
  end

  def authenticate_group_user_admin
    unless @group.group_users.where(user_id: current_user.id, admin: true).exists?
      redirect_to groups_path
    end
  end
end
