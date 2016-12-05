class CreateSubmitReviews < ActiveRecord::Migration
  def change
    create_table :submit_reviews do |t|
      t.integer :user_id
      t.integer :course_id
      t.boolean :take_action, default: false
      t.timestamps null: false
    end
  end
end
