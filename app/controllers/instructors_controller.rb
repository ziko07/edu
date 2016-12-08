class InstructorsController < ApplicationController
  before_filter :authenticate_user!

  def dashboard
    @courses = current_user.courses
  end

  def profile
    @instructor = User.friendly.find(params[:id])
  end

  def review_submit
    course = Course.friendly.find(params[:id])
    status = CourseStatus.find_by_name(AppData::COURSE_STATUS[:pending_review])
    if course.present? && status.present?
      if course.update_attribute('course_status_id', status.id)
        CourseNotification.review_course(course).deliver
        flash[:success] = "This course is now submitted for review. You will receive email notification as soon as it's approved"
      else
        flash[:danger] = 'Something wrong please try again!'
      end
      redirect_to edit_course_path(course)
    else
      redirect_to dashboard_instructors_path, danger: 'Something wrong please try again!'
    end
  end

end
