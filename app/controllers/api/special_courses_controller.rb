class Api::SpecialCoursesController < ApplicationController
  def show
    SpecialCourse.find(params[:id])
  end

  def create
    SpecialCourse.create(special_course_params)
  end

  private

  def special_course_params
    params.require(:special_course).permit(
      :title,
      :ects_points
    )
  end
end
