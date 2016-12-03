module AdminHelper
  def pending_course_notification(courses)
    pending_courses = courses.pending_review.count
    return 'No pending course to review' if pending_courses <= 0
    notification = "<div class='center-item'> <i class='fa fa-caret-right'></i>"
    link = link_to admin_courses_path + '#pending-review', class: 'admin-alart-link' do
      " #{pending_courses} #{'Course'.pluralize(pending_courses)}"
    end
    raw(notification + link + '</div>')
  end
end
