class CourseNotification < ApplicationMailer
  def review_course(course)
    @course = course
    mail(to: User::ADMIN_EMAILS, subject: 'Review the course')
  end
end
