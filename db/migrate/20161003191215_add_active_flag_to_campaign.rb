class AddActiveFlagToCampaign < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :active, :boolean, default: false, null: false
    campaign = Campaign.find_by('start_date <= ? AND ? <= end_date', Date.today, Date.today)
    campaign&.update(active: true)
  end
end
