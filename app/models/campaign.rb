class Campaign < ApplicationRecord
  has_many :proposals

  validates :title, presence: true
  validates :description, presence: true
  validates :budget, numericality: { greater_than_or_equal_to: 0 }
  validates :start_date, presence: true
  validates :end_date, presence: true, date: { after_or_equal_to: :start_date}

  def self.current
    find_by(active: true)
  end

  def pending?
    Date.today < start_date
  end

  def open?
    Date.today >= start_date && Date.today <= end_date
  end

  def closed?
    Date.today > end_date
  end

  def voted_proposals
    ids = proposals.map{ |p| { proposal: p, votes: p.voters.size } }.sort_by{ |e| e[:votes] }.reject{ |e| e[:votes].zero? }.reverse.each_with_object([]) do |e, result|
      result << e[:proposal] if ((result.map(&:budget).reduce(:+) || 0) + e[:proposal].budget) <= budget
    end.map(&:id)
    Proposal.where(id: ids)
  end
end
