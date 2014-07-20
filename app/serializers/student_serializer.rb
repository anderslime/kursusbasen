class StudentSerializer < ActiveModel::Serializer
  embed :ids

  attributes :id, :student_number
  has_many :planned_courses
end
