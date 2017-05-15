class VoterSecret < ApplicationRecord
  store_accessor :data

  def self.list_of_secrets
    query = <<~EOQ
      SELECT distinct skeys(data) FROM voter_secrets;
    EOQ

    VoterSecret.connection.execute(query).values.flatten
  end
end
