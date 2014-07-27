class CoursesScheduleGroups < ActiveRecord::Migration
  def change
    create_table :courses_schedule_groups do |t|
      t.integer :course_id
      t.integer :schedule_group_id
    end
    add_index :courses_schedule_groups, [:course_id, :schedule_group_id], unique: true,
      name: 'unique_courses_schedule_groups'
  end
end
