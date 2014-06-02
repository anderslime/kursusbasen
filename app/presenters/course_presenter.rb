class CoursePresenter < ApplicationPresenter
  presents :course

  delegate :title, :course_number, :teaching_form, :participant_limit,
           :top_comment, :schedule_note, :exam_schedule_note,
           :evaluation_form, :exam_duration, to: :course

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

  def short_institute_title
    course.institute_short_title
  end

  def institute_title
    course.institute_full_title
  end

  def teached_under_open_education?
    course.open_education?
  end

  def language
    I18n.t("generic.languages.#{course.language}")
  end

  def calendar_block_type
    [schedule_season_blocks, course_duration_in_parentheses].flatten.compact.join(" ")
  end

  def registration
    return course.registration unless default_campus_net_registration?
    registration_link_to_campus_net
  end

  def any_remarks?
    course.remarks.present?
  end

  def remarks
    h.simple_format(course.remarks)
  end

  private

  def registration_link_to_campus_net
    h.link_to(
      I18n.t('courses.show.default_registration_text'),
      "http://cn.dtu.dk",
      target: :_blank
    )
  end

  def default_campus_net_registration?
    course.registration == "I CampusNet" || course.registration == "At CampusNet"
  end

  def course_duration_in_parentheses
    "(" + course.duration + ")"
  end

  def schedule_season_blocks
    schedule_season_block_sentence && schedule_season_block_sentence.capitalize
  end

  def schedule_season_block_sentence
    course.schedule_season_blocks.map do |season_block|
      I18n.t("generic.course.schedule_season_blocks_types.#{season_block}")
    end.to_sentence.presence
  end

  def rounded_ects_points
    return course.ects_points if course.ects_points % 1.0 != 0
    course.ects_points.to_i
  end
end
