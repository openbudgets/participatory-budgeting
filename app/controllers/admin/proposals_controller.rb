class Admin::ProposalsController < AdminController
  before_action :set_proposal, only: [:show, :edit, :update, :destroy]
  before_action :set_classifiers, only: [:new, :edit]

  def index
    @proposals = Proposal.all.order(updated_at: :desc)
  end

  def show
  end

  def new
    @proposal = Proposal.new
  end

  def edit
  end

  def create
    @proposal = Proposal.new(proposal_params)

    if @proposal.save
      redirect_to admin_proposals_path, success: _('Proposal was successfully created.')
    else
      flash.now[:error] = @proposal.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @proposal.update(proposal_params)
      redirect_to admin_proposals_path, success: _('Proposal was successfully updated.')
    else
      flash.now[:error] = @proposal.errors.full_messages.to_sentence
      set_classifiers
      render :edit
    end
  end

  def destroy
    @proposal.destroy
    redirect_to admin_proposals_url, success: _('Proposal was successfully destroyed.')
  end

  private

  def set_proposal
    @proposal = Proposal.find(params[:id])
  end

  def set_classifiers
    @districts = District.all
    @areas = Area.all
    @tags  = Tag.all
  end

  def proposal_params
    p = params.require(:proposal).permit(:title, :description, :budget, :image, :completed, :district_id, :area_id, tag_ids: [])
    if p[:budget]
      p[:budget] = p[:budget].gsub(I18n.t('number.currency.format.delimiter'), '_')
      p[:budget] = p[:budget].gsub(I18n.t('number.currency.format.separator'), '.')
      p[:budget]
    end
    p[:image] = nil if params[:delete_image]
    p
  end
end
