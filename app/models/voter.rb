class Voter < ApplicationRecord
  has_and_belongs_to_many :proposals

  validates :email, format: /@/

  def verify!
    self.verified = true
    self.verification_token = nil
    self.save!
  end

  def generate_verification_token!
    self.verification_token = secure_token.to_i(16).to_s(36)
    self.save!
    self.verification_token
  end

  def voted?(proposal)
    return false unless proposal
    proposals.include?(proposal)
  end

  def to_s
    name || email
  end
end
