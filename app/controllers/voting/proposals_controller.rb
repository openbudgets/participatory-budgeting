class Voting::ProposalsController < ApplicationController
  before_action :validate_phase!

  def index
    if session[:verification_pending]
      flash.now[:notice] = _('<strong>Verification pending</strong>, please see your inbox for further instructions.')
    end
    @campaign_budget = Campaign.current.budget

    classifiers_filter = params[:class].split(',').map(&:to_i) if params[:class]
    budget_min_filter = params[:budget_min]
    budget_max_filter = params[:budget_max]
    @proposals = Campaign.current.proposals.includes(:classifiers)
    @budget_max = @proposals.max_by(&:budget)&.budget&.ceil || 0

    @proposals = @proposals.with_class(*classifiers_filter) unless classifiers_filter.blank?
    @proposals = @proposals.budget_min(budget_min_filter)   unless budget_min_filter.blank?
    @proposals = @proposals.budget_max(budget_max_filter)   unless budget_max_filter.blank?
    @proposals = @proposals.shuffle

    classifiers = @proposals.flat_map(&:classifiers).uniq
    @districts = classifiers.select{ |_| _.is_a?(District) }
    @areas = classifiers.select { |_| _.is_a?(Area) }
    @tags = classifiers.select { |_| _.is_a?(Tag) }
    render json: { proposals_ids: @proposals.map(&:id) } and return if xhr_request?
  end

  def show
    @proposal = Proposal.find(params[:id])
  end

  def update
    @proposal = Proposal.find(params[:id])
    result = if @proposal.voted_by?(current_voter)
      UnvoteProposal.call(current_voter, @proposal)
    else
      VoteProposal.call(current_voter, @proposal)
    end

    if result
      head :no_content
    else
      head :unprocessable_entity, error: _('There was an error while trying to register your vote.')
    end
  end

  def summarize
    if current_voter
      @proposals = current_voter.proposals.order(budget: :desc)
      flash.now[:notice] = _('Your vote has been registered successfully.')
    else
      referer = request.referer || new_voter_path(referer: request.path)
      redirect_to referer, alert: _('You need to <strong>sign in</strong> in order to view your vote.')
    end
  end

  private

  def validate_phase!
    redirect_to root_path unless Campaign.current.open?
  end
end
