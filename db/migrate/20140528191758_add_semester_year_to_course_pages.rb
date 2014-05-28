class AddSemesterYearToCoursePages < ActiveRecord::Migration
  def change
    add_column :course_pages, :semester_year, :string
    add_index :course_pages, [:course_number, :semester_year]
  end
end
