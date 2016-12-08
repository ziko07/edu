class AddAssignedAdminPasswordFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :assigned_admin_password, :boolean, default: false
  end
end
