class Proposal < ApplicationRecord
  has_and_belongs_to_many :voters
  has_and_belongs_to_many :classifiers
  belongs_to :campaign, optional: true
  has_many :comments

  validates :title, presence: true
  validates :description, presence: true
  validates :budget, numericality: { greater_than_or_equal_to: 0 }

  scope :budget_min, -> (amount) { where('budget >= ?', BigDecimal(amount)) }
  scope :budget_max, -> (amount) { where('budget <= ?', BigDecimal(amount)) }
  scope :with_class, -> (*classifier_ids) do
    base = joins(:classifiers).where(classifiers: { id: classifier_ids })
    with_districts = base.where(classifiers: { type: 'District' })
    with_areas     = base.where(classifiers: { type: 'Area' })
    with_tags      = base.where(classifiers: { type: 'Tag' })
    filtered = [with_districts, with_areas, with_tags].reject(&:empty?).reduce(&:&)
    (where(id: filtered.map(&:id)) unless filtered.blank?) || all
  end

  include ProposalImageUploader[:image]

  def district
    classifiers.find_by(type: :District)
  end

  def district_id
    district&.id
  end

  def district_id=(district_id)
    return if district&.id == district_id.to_i
    classifiers.delete(district) if classifiers.include?(district)
    classifiers << District.find(district_id)
  end

  def area
    classifiers.find_by(type: :Area)
  end

  def area_id
    area&.id
  end

  def area_id=(area_id)
    return if area&.id == area_id.to_i
    classifiers.delete(area) if classifiers.include?(area)
    classifiers << Area.find(area_id)
  end

  def tags
    classifiers.where(type: :Tag)
  end

  def tag_ids
    tags&.pluck(:id)
  end

  def tag_ids=(tag_ids)
    # TODO: selective removal and addition
    classifiers.delete(tags) unless classifiers.blank?
    classifiers << Tag.where(id: tag_ids)
  end

  def voted_by?(voter)
    return false unless voter
    voters.include?(voter)
  end

  def votes
    voters.size
  end

  def chosen?
    campaign.closed? && campaign.voted_proposals.include?(self)
  end

  def discarded?
    campaign.closed? && !campaign.voted_proposals.include?(self)
  end

  def status
    return :completed if completed?
    return :in_progress if chosen?
    return :discarded if discarded?
    :pending
  end

  def threaded_comments
    return [] if comments.empty?
    threads = comments.group_by{ |c| c.parent&.id  }
    threads.default = []
    tree = lambda do |comment, level|
      [ { value:comment, level: level }, threads[comment&.id].map{ |c| tree.call(c, level + 1) } ]
    end
    tree.call(nil, -1).flatten[1..-1]
  end
end
