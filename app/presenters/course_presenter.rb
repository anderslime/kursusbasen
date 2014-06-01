class CoursePresenter < ApplicationPresenter
  presents :course

  delegate :title, :course_number, :teaching_form, :participant_limit, to: :course

  def title_with_course_number
    [course.course_number, course.title].join(" ")
  end

  def truncated_content(length = 200)
    h.truncate(course.content, length: length)
  end

  def ects_points
    [rounded_ects_points, "ECTS Points"].join(" ")
  end

  def profile_url
    h.course_path(course)
  end

  def main_course_type
    "Grundlæggende civilkursus"
  end

  def teached_as_open_education?
    true
  end

  def course_objectives
    h.simple_format(course.course_objectives)
  end

  def content
    h.simple_format(course.content)
  end

  def course_website_link?
    course.homepage.present?
  end

  def course_website_link
    h.link_to(course.homepage, course.homepage)
  end

  def institute_title
    course.institute_full_title
  end

  private

  def rounded_ects_points
    return course.ects_points if course.ects_points % 1.0 != 0
    course.ects_points.to_i
  end
end
