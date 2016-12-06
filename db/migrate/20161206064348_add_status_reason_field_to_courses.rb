class AddStatusReasonFieldToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :status_reason, :text
  end
end
