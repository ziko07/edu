class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_admin!

  def dashboard
    @courses = Course.all
  end

  def instructors

  end

  def view_instructor

  end

  def new_instructor

  end

  def settings

  end

  def courses
    @courses = Course.all
    @group_course = CourseStatus.joins(:courses).group('name').count
  end

  def update_course
    @course = Course.find_by_id(params[:id])
    if @course.present?
      @prev_status = @course.course_status.name
      @course.update_attribute('course_status_id', params[:status])
      @group_course = CourseStatus.joins(:courses).group('name').count
    end
    respond_to do |format|
      format.js {}
    end
  end

  def seo_pages

  end

  def edit_page

  end

  protected

  def authenticate_admin!
    if current_user.is_admin?
      true
    else
      redirect_to root_path, danger: 'Access denied, Only admin can access this page.'
    end
  end
end
