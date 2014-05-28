class CourseNumberIsAString < ActiveRecord::Migration
  def change
    change_column :course_pages, :course_number, :string, :null => false
  end
end
