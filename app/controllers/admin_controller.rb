class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_admin!

  def dashboard
    @courses = Course.all
  end

  def instructors
    @instructors = User.where('email NOT IN (?)', User::ADMIN_EMAILS)
  end

  def view_instructor
    @instructor = User.find_by_id(params['user_id'])
    redirect_to admin_instructors_path, danger: 'Instructor not found' unless @instructor.present?
  end

  def new_instructor
    @instructor = User.new
  end

  def create_instructor
    puts params.inspect
    @instructor = User.new(instructor_params)
    if @instructor.save
      redirect_to admin_instructors_path, success: 'Instructor has been added successfully'
    else
      render :new_instructor
    end
  end

  def update_instructor

  end

  def reset_password

  end

  def settings

  end

  def update

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

  def instructor_params
    params.require(:user).permit!
  end

end
