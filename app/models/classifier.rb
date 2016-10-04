class Classifier < ApplicationRecord
  validates :name, presence: true
  validates :type, presence: true

  def to_s
    name
  end
end
