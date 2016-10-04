class AddCompletedFlagToProposal < ActiveRecord::Migration[5.0]
  def change
    add_column :proposals, :completed, :boolean, default: false, null: false
  end
end
