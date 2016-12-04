class ChangeDefaultValueOfCourseStatusIdAtCourses < ActiveRecord::Migration
  def change
    change_column_default :courses, :course_status_id, nil
  end
end
