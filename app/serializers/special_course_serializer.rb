class SpecialCourseSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :title, :ects_points
  has_many :schedule_groups
end
