class CoursePlanning < ActiveRecord::Base
  SEMESTER_SEASONS = ['autumn', 'spring']

  belongs_to :student
  belongs_to :course
  belongs_to :schedule_group

  validates_presence_of :student, :course
  validates_uniqueness_of :course_id, scope: [:student_id]
  validates_inclusion_of :semester_season_start, in: SEMESTER_SEASONS,
    unless: -> (cp){ cp.semester_season_start.nil? }
end
