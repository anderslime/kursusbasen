class CourseSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :course_number, :title, :ects_points, :schedule_blocks

  def schedule_blocks
    object.schedules.map(&:block).compact
  end
end
