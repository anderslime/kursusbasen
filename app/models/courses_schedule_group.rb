class CoursesScheduleGroup < ActiveRecord::Base
  belongs_to :course
  belongs_to :schedule_group
end
