class Responsible
  attr_reader :name, :office_location, :phone, :email, :dtu_teacher_id

  def initialize(name, office_location, phone, email, dtu_teacher_id)
    @name            = name
    @office_location = office_location
    @phone           = phone
    @email           = email
    @dtu_teacher_id  = dtu_teacher_id
  end
end
