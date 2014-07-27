class SpecialCourseSerializer < ActiveModel::Serializer
  attributes :id, :title, :ects_points
  has_one :student
end
