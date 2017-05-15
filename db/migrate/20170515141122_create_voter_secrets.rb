class CreateVoterSecrets < ActiveRecord::Migration[5.0]
  def change
    create_table :voter_secrets do |t|
      t.hstore :data, null: false, default: {}

      t.timestamps
    end
    add_index :voter_secrets, :data, using: :gin
  end
end
