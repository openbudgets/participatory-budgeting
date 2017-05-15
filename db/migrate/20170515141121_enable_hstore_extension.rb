class EnableHstoreExtension < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'hstore'
  end
end
