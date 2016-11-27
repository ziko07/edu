class CoursesController < ApplicationController
  # Check instructor before all action except index.
  before_filter :authenticate_user!, except: [:show]
  before_action :set_course, only: [:edit, :update, :show]
  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.build(course_params)
    respond_to do |format|
      if @course.save
        format.html{ redirect_to edit_course_path(@course), success: "Successfully new course created" }
        format.js { flash[:success] = "Successfully new course created" }
      else
        format.html{ redirect_to new_course_path, danger: "Couldn't be created" }
        format.js { flash[:success] = "Couldn't be created" }
      end
    end
  end

  def edit

  end

  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html{ redirect_to edit_course_path(@course), success: "Successfully course updated" }
        format.js { flash[:success] = "Successfully course updated" }
      else
        format.html{ redirect_to edit_course_path(@course), danger: "Couldn't be updated" }
        format.js { flash[:success] = "Couldn't be updated" }
      end
    end
  end

  def delete

  end

  def index

  end

  def category_courses

  end

  def show

  end

  private

  def set_course
    @course = Course.friendly.find(params[:id])
  end

  def course_params
    params.require(:course).permit!
  end

end
