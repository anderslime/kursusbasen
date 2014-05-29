class CourseNumberIsAStringV2 < ActiveRecord::Migration
  def up
    change_column :courses, :course_number, :string, :null => false
  end
end
