class RenameProposalAttributes < ActiveRecord::Migration[5.0]
  def change
    change_table :proposals do |t|
      t.rename :name, :title
      t.rename :budget_amount, :budget
    end
  end
end
