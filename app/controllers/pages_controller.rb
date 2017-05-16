class PagesController < ApplicationController
  def home
    if session[:verification_pending]
      flash.now[:notice] = _('<strong>Verification pending</strong>, please see your inbox for further instructions.')
    end
    @campaign = Campaign.current
  end
end
