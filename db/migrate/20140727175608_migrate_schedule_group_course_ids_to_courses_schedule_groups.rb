class MigrateScheduleGroupCourseIdsToCoursesScheduleGroups < ActiveRecord::Migration
  def up
    ScheduleGroup.all.each do |schedule_group|
      course = Course.find(schedule_group.course_id)
      course.schedule_groups << schedule_group
      course.save!
    end

    remove_column :schedule_groups, :course_id, :integer
  end

  def down
  end
end
