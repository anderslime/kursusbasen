class CourseSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :course_number, :title, :ects_points
  has_many :schedule_groups
end
