class CoursePlanning < ActiveRecord::Base
  SEMESTER_SEASONS = ['autumn', 'spring']
  PROGRAMMES = ['bachelor', 'master']
  BACHELOR_CATEGORIES = [
    'basic_elective', 'project_and_general',
    'natural_science', 'technological_programme_course'
  ]
  MASTER_CATEGORIES = [
    'advanced_elective', 'thesis',
    'general_competence', 'technological_specialization'
  ]
  COURSE_CATEGORIES = BACHELOR_CATEGORIES + MASTER_CATEGORIES

  belongs_to :student
  belongs_to :course, polymorphic: true
  belongs_to :schedule_group

  validates_presence_of :student, :course
  validates_uniqueness_of :course_id, scope: [:student_id]
  validates_inclusion_of :semester_season_start,
    in: SEMESTER_SEASONS,
    allow_blank: true
  validates_inclusion_of :programme,in: PROGRAMMES, allow_blank: true
  validates_inclusion_of :category,
    in: BACHELOR_CATEGORIES,
    if: -> (cp) { cp.planned_for_bachelor? },
    allow_blank: true
  validates_inclusion_of :category,
    in: MASTER_CATEGORIES,
    if: -> (cp) { cp.planned_for_master? },
    allow_blank: true

  def planned_for_master?
    MASTER_CATEGORIES.include?(category)
  end

  def planned_for_bachelor?
    BACHELOR_CATEGORIES.include?(category)
  end
end
