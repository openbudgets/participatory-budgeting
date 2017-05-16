class Monitoring::CommentsController < ApplicationController
  def create
    set_proposal
    set_parent
    if RegisterComment.call(text, current_voter, @proposal, @parent)
      flash[:success] = _('Your comment was successfully registered.')
    else
      flash[:error] = _('There was a problem registering your comment.')
    end
    redirect_to monitoring_proposal_path(@proposal)
  end

  private

  def set_proposal
    @proposal = Proposal.find(proposal_id)
  end

  def set_parent
    @parent = Comment.find_by(id: parent_id)
  end

  def proposal_id
    params[:proposal_id]
  end

  def parent_id
    comment_params[:comment_id]
  end

  def text
    comment_params[:text]
  end

  def comment_params
    params.require(:comment).permit(:text, :comment_id)
  end
end
