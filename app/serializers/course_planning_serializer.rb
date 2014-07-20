class CoursePlanningSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id
  has_one :student
  has_one :course
end
