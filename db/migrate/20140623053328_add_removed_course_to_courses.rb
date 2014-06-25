class AddRemovedCourseToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :removed, :boolean, default: false, null: false
  end
end
