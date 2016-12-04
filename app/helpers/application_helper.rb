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

  def active_tab(con_name, ac_name)
    if con_name == controller_name && ac_name.include?(action_name)
      'active_admin_side_bar'
    end
  end

  def admin
    current_user
  end

end
