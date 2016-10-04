class AddCampaignReferenceToProposal < ActiveRecord::Migration[5.0]
  def change
    add_reference :proposals, :campaign, foreign_key: true
    Proposal.find_each do |p|
      p.update(campaign: Campaign.current)
    end
  end
end
