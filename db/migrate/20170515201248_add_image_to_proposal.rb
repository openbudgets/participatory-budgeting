class AddImageToProposal < ActiveRecord::Migration[5.0]
  def change
    add_column :proposals, :image_data, :text
  end
end
