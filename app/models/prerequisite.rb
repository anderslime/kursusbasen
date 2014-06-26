class Prerequisite < ActiveRecord::Base
  has_and_belongs_to_many :course_options, class_name: "Course"
  self.inheritance_column = :prerequisite_type

  validates_presence_of :course_id
end
