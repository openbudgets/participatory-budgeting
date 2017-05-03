class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_voter
  helper_method :admin_role?

  add_flash_types :success, :error

  def current_voter
    @current_voter ||= Voter.find_by(id: session[:voter])
  end

  def admin_role?
    roles = Admin::Role.all.pluck(:email)
    roles.any?{ |role| current_voter&.email&.include?(role) }
  end

  def sign_in(voter)
    session[:voter] = voter.id
  end

  def sign_out
    session.delete(:voter)
  end

  def current_redirect!
    params[:redirect] || (session[:verification_pending] ? session[:redirect] : session.delete(:redirect)) || root_path
  end

  def update_current_redirect_with(redirect)
    if redirect
      session[:redirect] = redirect
    else
      session.delete(:redirect)
    end
  end

  def xhr_request?
    request.headers['HTTP_X_REQUESTED_WITH'] == 'XMLHttpRequest'
  end
end