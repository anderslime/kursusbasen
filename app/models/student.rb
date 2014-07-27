class Student < ActiveRecord::Base
  to_param :student_number

  has_many :course_plannings

  validates_uniqueness_of :student_number

  def plans_to_attend_course?(course)
    planned_courses.include?(course)
  end

  private

  def planned_courses
    course_plannings.map(&:course)
  end
end
