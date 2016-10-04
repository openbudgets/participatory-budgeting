class AddNameToVoter < ActiveRecord::Migration[5.0]
  def change
    add_column :voters, :name, :string
  end
end
