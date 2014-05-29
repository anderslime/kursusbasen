class CoursesController < ApplicationController
  def index
    @courses = Course.all.paginate(page: params[:page])
  end
end
