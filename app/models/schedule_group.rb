class ScheduleGroup < ActiveRecord::Base
  has_many :schedules, :dependent => :destroy
  validates_presence_of :course_id
end
