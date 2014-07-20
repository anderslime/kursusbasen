class CourseView
  attr_reader :course
  attr_accessor :view_context

  delegate :course_number, :title, :ects_points, :main_course_type,
           :teached_under_open_education?, :course_objectives, :content,
           :teaching_form, :course_website_link?, :course_website_link,
           :participant_limit, :institute_title, :top_comment,
           :short_institute_title, :language, :calendar_block_type,
           :schedule_note, :exam_schedule_note, :registration,
           :any_remarks?, :remarks, :evaluation_form,
           :exam_duration, :learn_objectives, :add_to_study_plan_button,
           to: :course_presenter

  def initialize(course)
    @course = course
  end

  def render_teachers
    view_context.render(
      'course_teachers',
      course_teacher_presenters: course_teacher_presenters
    )
  end

  def render_course_schedule
    view_context.render(
      'course_schedule',
      schedule: CourseScheduleView.new(view_context, course.schedules.including_block),
      schedule_groups: schedule_groups
    )
  end

  def render_qualified_prerequisites
    return nil unless course.any_qualified_prerequisites?
    view_context.render(
      'prerequisites',
      prerequisites: course.qualified_prerequisites,
      header: I18n.t('courses.qualified_prerequisites.header')
    )
  end

  def render_mandatory_prerequisites
    return nil unless course.any_mandatory_prerequisites?
    view_context.render(
      'prerequisites',
      prerequisites: course.mandatory_prerequisites,
      header: I18n.t('courses.mandatory_prerequisites.header')
    )
  end

  private

  def schedule_groups
    ScheduleCollectionTranslator.new(course.schedule_groups).translated_schedules
  end

  def course_teacher_presenters
    course.teachers.map do |teacher|
      TeacherPresenter.new(teacher, view_context)
    end
  end

  def course_presenter
    CoursePresenter.new(course, view_context)
  end
end
