class CoursePage < ActiveRecord::Base
  class << self
    def find_by_course_number(course_number)
      find_by(course_number: course_number)
    end

    def exists_with_course_number?(course_number)
      exists?(course_number: course_number)
    end
  end
end
