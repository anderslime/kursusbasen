class Api::CoursePlanningsController < ApplicationController
  respond_to :json

  def create
    course_planning =
      current_student.course_plannings.create(course_plannings_params)
    respond_with :api, course_planning
  end

  private

  def course_plannings_params
    params.require(:course_planning).permit(:course_id)
  end
end
