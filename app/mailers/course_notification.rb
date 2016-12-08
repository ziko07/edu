class CourseNotification < ApplicationMailer
  def review_course(course)
    @course = course
    mail(to: User::ADMIN_EMAILS, subject: 'Review the course')
  end

  def rejected(course)
    @course = course
    @instructor = course.user
    mail(to: @instructor.email, subject: 'Course rejected notification!')
  end

  def unpublished(course)
    @course = course
    @instructor = course.user
    mail(to: @instructor.email, subject: 'Course unpublished notification!')
  end

  def published(course)
    @course = course
    @instructor = course.user
    mail(to: @instructor.email, subject: 'Course published notification')
  end

end
