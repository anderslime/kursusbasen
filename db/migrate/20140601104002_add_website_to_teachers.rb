class AddWebsiteToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :website, :string
  end
end
