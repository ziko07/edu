class UserNotification < ApplicationMailer
  def reset_password(instructor, password)
    @instructor = instructor
    @password = password
    mail(to: @instructor.email, subject: 'Reset password by admin')
  end

  def unpublished(instructor)
    @instructor = instructor
    mail(to: @instructor.email, subject: 'Reset password by admin')
  end
end
