class CreateClassifiers < ActiveRecord::Migration[5.0]
  def change
    create_table :classifiers do |t|
      t.string :name, null: false
      t.string :type, null: false
      t.references :classifier, index: true, foreign_key: true

      t.timestamps
    end
  end
end
