class CreateJoinTableProposalsVoters < ActiveRecord::Migration[5.0]
  def change
    create_join_table :proposals, :voters do |t|
      t.references :proposal, foreign_key: true
      t.references :voter, foreign_key: true
      t.index [:voter_id, :proposal_id], unique: true
    end
  end
end
