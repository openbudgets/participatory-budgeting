class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.string :token, null: false
      t.references :voter, foreign_key: true

      t.timestamps
    end
    add_index :votes, :token, unique: true
  end
end
