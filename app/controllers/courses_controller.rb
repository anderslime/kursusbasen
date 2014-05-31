class CoursesController < ApplicationController
  def index
    @courses = Course.search(params[:course_search] || {}, params[:page])
  end

  def show
    @course = Course.find_by_course_number(params[:id])
  end
end
