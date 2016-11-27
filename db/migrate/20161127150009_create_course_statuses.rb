class CreateCourseStatuses < ActiveRecord::Migration
  def change
    create_table :course_statuses do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
