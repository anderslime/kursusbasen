class CoursePlanningsHasScheduleGroups < ActiveRecord::Migration
  def change
    remove_column :course_plannings, :season, :string
    remove_column :course_plannings, :year, :integer
    add_column :course_plannings, :schedule_group_id, :integer
  end
end
