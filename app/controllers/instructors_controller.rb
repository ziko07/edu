class InstructorsController < ApplicationController

  def new
    @instructor = User.new
    respond_to do |format|
      format.js
    end
  end

  def create

  end

  def dashboard

  end

  def new_course

  end

  def create_course

  end

  def edit_course

  end

  def update_course

  end


end
