class Api::PlannedCoursesController < ApplicationController
  respond_to :json

  def create
    planned_course =
      current_student.planned_courses.create(planned_courses_params)
    respond_with :api, planned_course
  end

  private

  def planned_courses_params
    params.require(:planned_course).permit(:course_id)
  end
end
