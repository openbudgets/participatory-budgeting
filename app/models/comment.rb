class Comment < ApplicationRecord
  belongs_to :voter
  belongs_to :parent, class_name: 'Comment', foreign_key: 'comment_id', optional: true
  belongs_to :proposal
  has_many :responses, class_name: 'Comment'

  validates :text, presence: true
end
