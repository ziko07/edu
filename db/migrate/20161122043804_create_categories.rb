class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.string :image
      t.string :slug
      t.integer :position

      t.timestamps null: false
    end
  end
end
