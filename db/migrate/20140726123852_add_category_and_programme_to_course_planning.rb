class AddCategoryAndProgrammeToCoursePlanning < ActiveRecord::Migration
  def change
    add_column :course_plannings, :category, :string
    add_column :course_plannings, :programme, :string
  end
end
