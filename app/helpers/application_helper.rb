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
      'active_admin_side_bar'
    end
  end

  def course_status(course)
    message = ''
    if course.course_status_id.nil?
      unless course.summary.present?
        message += 'Summary'
      end

      unless course.image.present?
        message = message.present? ? message + ' and ' : message
        message += 'Image'
      end

      if message.present?
        raw "<span style='color: #A62C39;' class='pull-right'> #{message} required to course submit </span>"
      else
        raw link_to 'Submit For Review', '#', class: 'btn btn-success pull-right'
      end
    else
      "Course status: #{course.course_status.name}"
    end
  end

end
