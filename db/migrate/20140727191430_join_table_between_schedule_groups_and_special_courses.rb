class JoinTableBetweenScheduleGroupsAndSpecialCourses < ActiveRecord::Migration
  def change
    create_table :special_courses_schedule_groups do |t|
      t.integer :special_course_id
      t.integer :schedule_group_id
    end
  end
end
