class AddCourseStatusIdToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :course_status_id, :integer, default: 1
  end
end
