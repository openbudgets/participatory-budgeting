class AdminController < ApplicationController
  before_action :require_admin_role

  private

  def require_admin_role
    redirect_to root_path, error: _('<strong>Admin role is necessary</strong> in order to access the admin area.') unless admin_role?
  end
end