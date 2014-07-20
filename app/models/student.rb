class Student < ActiveRecord::Base
  to_param :student_number

  has_many :course_plannings
  has_many :planned_courses, through: :course_plannings, source: :course

  validates_uniqueness_of :student_number

  def plans_to_attend_course?(course)
    planned_courses.include?(course)
  end
end
