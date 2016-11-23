module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def active_tab(current_controller, current_action, cntlr_name, acn_name)
      if current_controller == cntlr_name && acn_name.include?(current_action)
        return 'active_admin_side_bar'
      end
  end
end
