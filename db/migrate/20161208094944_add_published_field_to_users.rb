class AddPublishedFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :published, :boolean, default: true
  end
end