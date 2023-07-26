class LinksController < ApplicationController
  include HTTParty
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
    @link = @group.links.build(link_params) # build the link, don't save it yet
    @link.contributor=current_user.email

    response = HTTParty.get("https://jsonlink.io/api/extract?url=#{@link.url}")

    if response.code == 200
      if response.parsed_response["images"].present?
        @link.image_url = response.parsed_response["images"][0]
      end
      if response.parsed_response["title"].present?
        @link.name = response.parsed_response["title"]
      end
      if response.parsed_response["description"].present?
        @link.description = response.parsed_response["description"]
      end
    end

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
    params.require(:link).permit(:name, :url, :group_id, :description, :image_url)
  end
end
