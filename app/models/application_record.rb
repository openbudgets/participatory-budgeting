class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def secure_token
    SecureRandom.uuid.gsub('-','')
  end
end
