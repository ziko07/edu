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
        raw "<a class='btn btn-default btn-lg disabled reset-border-radius submit-for-review'>Submit for Review</a>"
      else
        raw link_to 'Submit for Review', review_submit_instructors_path(course), class: 'btn btn-lg btn-success reset-border-radius submit-for-review'
      end
    elsif course.course_status.name == AppData::COURSE_STATUS[:rejected] || course.course_status.name == AppData::COURSE_STATUS[:unpublished]
      html = "<div> <p style='color: #EA4335;'> This course is #{course.course_status.name} </p>"
      html += link_to 'Resubmit for Review', review_submit_instructors_path(course), class: 'btn btn-lg btn-success reset-border-radius submit-for-review'
      raw html + '</div>'
    else
      raw "<div class='alert alert-info'> This course is #{course.course_status.name} </div>"
    end
  end

  def admin
    current_user
  end

end
