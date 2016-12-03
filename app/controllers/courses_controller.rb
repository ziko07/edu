class CoursesController < ApplicationController
  # Check instructor before all action except index.
  before_filter :authenticate_user!, except: [:show, :category_courses, :index]
  before_action :set_course, only: [:edit, :update, :show]

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.build(course_params)
    respond_to do |format|
      if @course.save
        format.html { redirect_to edit_course_path(@course), success: "Your changes have been successfully saved." }
        format.js { flash[:success] = "Your changes have been successfully saved." }
      else
        format.html { redirect_to new_course_path, danger: "Couldn't be created" }
        format.js { flash[:success] = "Couldn't be created" }
      end
    end
  end

  def edit

  end

  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to edit_course_path(@course), success: 'Your changes have been successfully saved.' }
        format.js { flash[:success] = 'Your changes have been successfully saved.' }
      else
        format.html { redirect_to edit_course_path(@course), danger: "Couldn't be updated" }
        format.js { flash[:success] = "Couldn't be updated" }
      end
    end
  end

  def delete

  end

  def index
    @group_courses = Course.category_courses
  end

  def category_courses
    @category = Category.friendly.find(params[:category])
    @courses = @category.published_courses
  end

  def show

  end

  private

  def set_course
    begin
      @course = Course.friendly.find(params[:id])
      unless @course.user == current_user || current_user.is_admin?
        redirect_to root_path, danger: 'You have not access to this course'
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to :back, danger: 'Course Not Found'
    end
  end

  def course_params
    params.require(:course).permit!
  end

end
