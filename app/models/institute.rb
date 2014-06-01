class Institute < ActiveRecord::Base
  translates :title

  def full_title
    "#{dtu_institute_id} #{title}"
  end
end
