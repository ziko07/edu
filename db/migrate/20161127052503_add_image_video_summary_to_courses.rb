class AddImageVideoSummaryToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :summary, :text
    add_column :courses, :image, :string
    add_column :courses, :promo_video, :string
  end
end
