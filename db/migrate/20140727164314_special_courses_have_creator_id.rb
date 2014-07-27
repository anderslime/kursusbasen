class SpecialCoursesHaveCreatorId < ActiveRecord::Migration
  def change
    rename_column :special_courses, :student_id, :creator_id
  end
end
