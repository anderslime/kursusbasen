class CourseAutocompleteSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :course_number, :title, :ects_points
end
