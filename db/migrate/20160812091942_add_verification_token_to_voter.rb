class AddVerificationTokenToVoter < ActiveRecord::Migration[5.0]
  def change
    add_column :voters, :verification_token, :string
    add_index :voters, :verification_token, unique: true
  end
end
