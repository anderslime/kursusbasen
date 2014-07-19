class Student < ActiveRecord::Base
  to_param :student_number

  validates_uniqueness_of :student_number
end
