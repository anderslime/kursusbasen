class CourseView
  attr_reader :course
  attr_accessor :view_context

  delegate :course_number, :title, :ects_points, :main_course_type,
           :teached_as_open_education?, :course_objectives, :content,
           :teaching_form, :course_website_link?, :course_website_link,
           :participant_limit, to: :course_presenter

  def initialize(course)
    @course = course
  end

  def render_course_schedule
    view_context.render(
      'course_schedule',
      schedule: CourseSchedule.new(view_context, course.schedules)
    )
  end

  def course_presenter
    CoursePresenter.new(course, view_context)
  end
end
