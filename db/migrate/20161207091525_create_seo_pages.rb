class CreateSeoPages < ActiveRecord::Migration
  def change
    create_table :seo_pages do |t|
      t.string :meta_title
      t.text :meta_description
      t.string :url
      t.string :controller
      t.string :action
      t.timestamps null: false
    end
  end
end
