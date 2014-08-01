class Api::CoursePlanningsController < ApplicationController
  respond_to :json

  def create
    normal_course_plannings_params = course_plannings_params.merge(course_type: Course.name)
    course_planning =
      current_student.course_plannings.create(normal_course_plannings_params)
    respond_with :api, course_planning
  end

  def update
    course_planning = current_student.course_plannings.find(params[:id])
    course_planning.update(course_plannings_params)
    respond_with :api, course_planning
  end

  def destroy
    current_student.course_plannings.find(params[:id]).destroy
    head :ok
  end

  private

  def course_plannings_params
    params.require(:course_planning).permit(
      :course_id,
      :course_type,
      :schedule_group_id,
      :year,
      :semester_season_start,
      :programme,
      :category
    ).merge(programme: 'master')
  end
end
