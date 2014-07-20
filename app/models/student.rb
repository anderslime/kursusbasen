class Student < ActiveRecord::Base
  to_param :student_number

  has_many :planned_courses

  validates_uniqueness_of :student_number

  def plans_to_attend_course?(course)
    planned_courses.map(&:course_id).include?(course.id)
  end
end
