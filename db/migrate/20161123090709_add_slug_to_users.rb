class AddSlugToUsers < Activechange_column :users, :full_name, :first_name, :stringRecord::Migration
  def change
    add_column :users, :slug, :string, unique: true
  end
end
