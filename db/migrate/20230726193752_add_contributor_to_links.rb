class AddContributorToLinks < ActiveRecord::Migration[7.0]
  def change
    add_column :links, :contributor, :string
  end
end
