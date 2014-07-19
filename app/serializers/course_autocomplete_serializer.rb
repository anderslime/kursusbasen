class CourseAutocompleteSerializer < ActiveModel::Serializer
  attributes :id, :course_number, :title, :ects_points
end
