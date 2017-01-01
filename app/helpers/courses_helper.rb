module CoursesHelper
  def check_for_course_review(course)
    if course.course_status.present? && course.course_status.name == AppData::COURSE_STATUS[:pending_review]
      'disabled-course-submission'
    end
  end
end
