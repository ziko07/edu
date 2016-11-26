class AddCourseDescriptionsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :subtitle, :string
    add_column :courses, :category_id, :integer
  end
end
