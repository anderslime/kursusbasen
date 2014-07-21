class StudentSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :student_number
  has_many :course_plannings
end
