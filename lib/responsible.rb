class Responsible
  attr_reader :name, :dtu_teacher_id

  def initialize(name, dtu_teacher_id)
    @name            = name
    @dtu_teacher_id  = dtu_teacher_id
  end
end
