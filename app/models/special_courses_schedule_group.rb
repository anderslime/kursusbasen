class SpecialCoursesScheduleGroup < ActiveRecord::Base
  belongs_to :special_course
  belongs_to :schedule_group, dependent: :destroy
end
