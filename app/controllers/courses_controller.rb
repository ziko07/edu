class CoursesController < ApplicationController
  # Check instructor before all action except index.

  def new
    @course = Course.new
  end

  def create
    # After create redirect to course edit path
  end

  def edit

  end

  def update

  end

  def delete

  end

  def index

  end

  def category_courses

  end

  def show

  end

end
