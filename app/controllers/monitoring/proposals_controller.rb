class Monitoring::ProposalsController < ApplicationController
  before_action :validate_phase!

  def index
    classifiers_filter = params[:class].split(',').map(&:to_i) if params[:class]
    budget_min_filter = params[:budget_min]
    budget_max_filter = params[:budget_max]
    @proposals = Campaign.current.voted_proposals.includes(:classifiers)
    @budget_max = @proposals.max_by(&:budget)&.budget&.ceil || 0

    @proposals = @proposals.with_class(*classifiers_filter) unless classifiers_filter.blank?
    @proposals = @proposals.budget_min(budget_min_filter)   unless budget_min_filter.blank?
    @proposals = @proposals.budget_max(budget_max_filter)   unless budget_max_filter.blank?

    classifiers = @proposals.flat_map(&:classifiers).uniq
    @districts = classifiers.select{ |_| _.is_a?(District) }
    @areas = classifiers.select { |_| _.is_a?(Area) }
    @tags = classifiers.select { |_| _.is_a?(Tag) }
    render json: { proposals_ids: @proposals.map(&:id) } and return if xhr_request?
  end

  def show
    @proposal = Proposal.find(params[:id])
  end

  def summarize
    @proposals = Campaign.current.voted_proposals.order(budget: :desc)
  end

  private

  def validate_phase!
    redirect_to root_path unless Campaign.current.closed?
  end
end
