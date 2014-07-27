class SpecialCourseCreatorService
  attr_reader :special_course_params

  def initialize(special_course_params)
    @special_course_params = special_course_params
  end

  def create
    @special_course ||= SpecialCourse.create!(special_course_params) do |special_course|
      special_course.schedule_groups << default_schedule_group
    end
  end

  private

  def default_schedule_group
    schedule_group = ScheduleGroup.create!
    schedule_group.schedules.create!(season: 'unknown')
    schedule_group.save
    schedule_group
  end
end
