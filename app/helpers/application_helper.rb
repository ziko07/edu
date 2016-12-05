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
        raw link_to 'Submit for Review', 'javascript:void(0);', title: message + ' required to course submission', class: 'btn btn-default btn-lg disabled reset-border-radius'
      else
        raw link_to 'Submit for Review', review_submit_instructors_path(course), class: 'btn btn-lg btn-success reset-border-radius'
      end
    else
      raw "<div class='alert alert-info'> Course #{course.course_status.name.humanize} </div>"
    end
  end
  
  def admin
    current_user
  end

end
