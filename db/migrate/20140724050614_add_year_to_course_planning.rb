class AddYearToCoursePlanning < ActiveRecord::Migration
  def change
    add_column :course_plannings, :year, :integer
  end
end
