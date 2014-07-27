class SpecialCourse < ActiveRecord::Base
  has_many :special_courses_schedule_groups, dependent: :destroy
  has_many :schedule_groups, through: :special_courses_schedule_groups

  def creator
    Student.find(creator_id)
  end
end
