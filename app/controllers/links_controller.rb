class LinksController < ApplicationController
  before_action :set_group

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    redirect_to group_path(@link.group)
  end

  def new
    @link = Link.new
  end

  def create
    @link = @group.links.create(link_params)
    if @link.save
      redirect_to group_path(@group)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def link_params
    params.require(:link).permit(:name, :url)
  end
end
