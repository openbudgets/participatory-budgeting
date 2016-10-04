require_relative '20160804174304_create_votes'
require_relative '20160811104920_create_picks'

class RemoveVotesAndPicks < ActiveRecord::Migration[5.0]
  def change
    revert CreatePicks
    revert CreateVotes
  end
end
