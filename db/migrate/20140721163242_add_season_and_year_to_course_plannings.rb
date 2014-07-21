class AddSeasonAndYearToCoursePlannings < ActiveRecord::Migration
  def change
    add_column :course_plannings, :season, :string
    add_column :course_plannings, :year, :integer
  end
end
