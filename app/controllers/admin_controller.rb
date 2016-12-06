class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_admin!

  def dashboard
    @courses = Course.all
  end

  def instructors
    @instructors = User.where('email NOT IN (?)', User::ADMIN_EMAILS)
  end

  def edit_instructor
    @instructor = User.find_by_id(params[:id])
    redirect_to admin_instructors_path, danger: 'Instructor not found' unless @instructor.present?
  end

  def new_instructor
    @instructor = User.new
  end

  def create_instructor
    @instructor = User.new(instructor_params)
    if @instructor.save
      redirect_to admin_instructors_path, success: 'Instructor has been added successfully'
    else
      render :new_instructor
    end
  end

  def update_instructor
    @instructor = User.find_by_id(params[:id])
    redirect_to :back, danger: 'Instructor not found' unless @instructor.present?
    if @instructor.update_attributes(instructor_params)
      redirect_to admin_instructors_path, success: 'Instructor has been updated successfully'
    else
      render :edit_instructor
    end
  end

  def reset_password

  end

  def settings
    @user = current_user
  end

  def update
    @user = current_user
    setting_params = instructor_params
    unless setting_params[:password].present?
      setting_params.delete(:password)
      setting_params.delete(:password_confirmation)
    end
    if @user.update_attributes(setting_params)
      redirect_to admin_settings_path, success: 'Settings has been updated successfully'
    else
      render :settings
    end
  end

  def courses
    @courses = Course.where('course_status_id IS NOT NULL')
    @group_course = CourseStatus.joins(:courses).group('name').count
  end

  def update_course
    @course = Course.find_by_id(params[:id])
    @status = false
    if @course.present?
      @prev_status = @course.course_status.name
      @status = @course.update_attributes(course_status_id: params[:status], status_reason: params[:reason])
      @group_course = CourseStatus.joins(:courses).group('name').count
    end
    respond_to do |format|
      format.js {}
    end
  end

  protected

  def instructor_params
    params.require(:user).permit!
  end

end
