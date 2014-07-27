class SpecialCourse < ActiveRecord::Base
  def creator
    Student.find(creator_id)
  end
end
