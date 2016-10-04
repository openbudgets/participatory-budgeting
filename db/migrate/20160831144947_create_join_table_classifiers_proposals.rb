class CreateJoinTableClassifiersProposals < ActiveRecord::Migration[5.0]
  def change
    create_join_table :classifiers, :proposals do |t|
      t.references :classifier, foreign_key: true
      t.references :proposal, foreign_key: true
      t.index [:proposal_id, :classifier_id], unique: true
    end
  end
end
