class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.string :email, null: false
    end
    add_index :roles, :email, unique: true
  end
end
