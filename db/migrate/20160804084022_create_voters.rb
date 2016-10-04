class CreateVoters < ActiveRecord::Migration[5.0]
  def change
    create_table :voters do |t|
      t.string :email, null: false
      t.boolean :verified, default: false, null: false

      t.timestamps
    end
    add_index :voters, :email, unique: true
  end
end
