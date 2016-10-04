class RemoveClassifierReflexiveReference < ActiveRecord::Migration[5.0]
  def change
    remove_reference :classifiers, :classifier, index: true, foreign_key: true
  end
end
