class InstructorsController < ApplicationController
  before_filter :authenticate_user!
  def dashboard
    @courses = current_user.courses
  end

  def profile
    @instructor = User.friendly.find(params[:id])
  end
end
