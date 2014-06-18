class Teacher < ActiveRecord::Base
  validates_uniqueness_of :dtu_teacher_id, :if => Proc.new {|teacher| teacher.dtu_teacher_id.present? }

  class << self
    def find_by_dtu_teacher_id(dtu_teacher_id)
      find_by(dtu_teacher_id: dtu_teacher_id)
    end

    def find_by_name(name)
      find_by(name: name)
    end

    def excluding_teachers(dtu_teacher_ids)
      where.not(dtu_teacher_id: dtu_teacher_ids)
    end
  end
end
