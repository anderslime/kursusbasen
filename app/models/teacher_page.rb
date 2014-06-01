class TeacherPage < ActiveRecord::Base
  validates_uniqueness_of :dtu_teacher_id
end
