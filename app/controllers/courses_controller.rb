class CoursesController < ApplicationController
  def index
    @courses = Course.search(params[:course_search] || {}, params[:page])
  end

  def show
    course_view = CourseView.new(
      Course.find_by_course_number(params[:id])
    )
    render locals: { course_view: course_view }
  end
end
