class CoursePlanning < ActiveRecord::Base
  belongs_to :student
  belongs_to :course
  belongs_to :schedule_group

  validates_presence_of :student, :course
  validates_uniqueness_of :course_id, scope: [:student_id]
end
