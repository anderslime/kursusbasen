class CoursePage < ActiveRecord::Base
  class << self
    def find_by_course_number(course_number)
      find_by(course_number: course_number)
    end

    def exists_with_course_number_in_semester?(course_number, semester_year)
      exists?(course_number: course_number, semester_year: semester_year)
    end
  end
end
