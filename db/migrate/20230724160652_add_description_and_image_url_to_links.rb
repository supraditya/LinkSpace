class AddDescriptionAndImageUrlToLinks < ActiveRecord::Migration[7.0]
  def change
    add_column :links, :description, :text
    add_column :links, :image_url, :string
  end
end
