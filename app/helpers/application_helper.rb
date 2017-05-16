module ApplicationHelper
  def scope
    tokens = controller.controller_path.split('/')
    return '' if tokens.size == 1
    tokens.first
  end

  def admin_zone?
    scope == 'admin'
  end

  private

  def dynamic_translation_keys
    [ _('Birth date'), _('Document'),
      _('Pending'), _('Completed'), _('Discarded'), _('In progress') ].freeze
  end
end