module ApplicationHelper
  def scope
    tokens = controller.controller_path.split('/')
    return '' if tokens.size == 1
    tokens.first
  end

  def admin_zone?
    scope == 'admin'
  end
end
