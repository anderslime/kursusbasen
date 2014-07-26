class AddSemesterSeasonStartToCoursePlannings < ActiveRecord::Migration
  def change
    add_column :course_plannings, :semester_season_start, :string
  end
end
