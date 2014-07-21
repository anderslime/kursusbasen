class CoursePlanning < ActiveRecord::Base
  SEASONS = ['spring', 'autumn', 'summer', 'january', 'june']

  belongs_to :student
  belongs_to :course

  validates_presence_of :student, :course
  validates_uniqueness_of :course_id, scope: [:student_id]
  validates_inclusion_of :season, in: SEASONS, unless: -> (cp) { cp.season.nil? }
end
