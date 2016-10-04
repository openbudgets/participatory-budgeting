class CreatePicks < ActiveRecord::Migration[5.0]
  def change
    create_table :picks do |t|
      t.references :vote, foreign_key: true
      t.references :proposal, foreign_key: true

      t.timestamps
    end
  end
end
