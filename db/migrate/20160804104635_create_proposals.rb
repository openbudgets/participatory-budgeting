class CreateProposals < ActiveRecord::Migration[5.0]
  def change
    create_table :proposals do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.decimal :budget_amount, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
