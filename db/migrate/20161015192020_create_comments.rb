class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :text, null: false
      t.references :voter, foreign_key: true
      t.references :comment, foreign_key: true
      t.references :proposal, foreign_key: true

      t.timestamps
    end
  end
end
