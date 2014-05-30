class CoursePresenter < ApplicationPresenter
  presents :course

  def title_with_course_number
    [course.course_number, course.title].join(" ")
  end

  def truncated_content(length = 200)
    h.truncate(course.content, length: length)
  end

  def ects_points
    [rounded_ects_points, "ECTS Points"].join(" ")
  end

  private

  def rounded_ects_points
    return course.ects_points if course.ects_points % 1.0 != 0
    course.ects_points.to_i
  end
end
