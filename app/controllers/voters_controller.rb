class VotersController < ApplicationController
  def new
    update_current_redirect_with(params[:redirect]) if params[:redirect]
    @voter = Voter.new
  end

  def create
    email = params[:voter][:email]
    if RegisterVoter.call(email)
      session[:verification_pending] = true
      redirect_to current_redirect!, notice: "We've sent you a <strong>verification token</strong>, please see your inbox for further instructions"
    else
      redirect_to new_voter_path, error: "Something went wrong with the registration process. Please, <strong>try again</strong>"
    end
  end

  def update
    @voter = Voter.find(params[:id])
    @voter.name = params[:voter][:name] if params[:voter] && !params[:voter][:name].blank?
    verify!
  end

  def verify
    @voter = Voter.find_by(verification_token: params[:token])
    if !@voter
      redirect_to new_voter_path, error: "Something went wrong with the verification process. Please, <strong>try again</strong>"
    elsif !@voter.verified? || !@voter.name
      render :verify
    else
      verify!
    end
  end

  def signout
    sign_out
    redirect_to root_path, success: "<strong>Successfully signed out</strong>, sign in again to review your votes"
  end

  private

  def verify!
    @voter.verify!
    session.delete(:verification_pending)
    sign_in(@voter)
    redirect_to current_redirect!, success: "<strong>Successfully verified</strong>, you can now take part in the participatory budgeting process"
  end
end
