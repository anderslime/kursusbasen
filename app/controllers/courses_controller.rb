class CoursesController < ApplicationController
  def index
    @courses = Course.search(params[:course_search] || {}, params[:page])
  end
end
