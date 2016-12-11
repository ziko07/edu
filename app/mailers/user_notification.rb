class UserNotification < ApplicationMailer
  def reset_password(instructor, password)
    @instructor = instructor
    @password = password
    mail(to: @instructor.email, subject: 'Reset password by admin')
  end

  def unpublished(instructor)
    @instructor = instructor
    mail(to: @instructor.email, subject: 'Your profile unpublished by admin')
  end

  def published(instructor)
    @instructor = instructor
    mail(to: @instructor.email, subject: 'Your profile published by admin')
  end
end
