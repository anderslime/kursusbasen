class Institute < ActiveRecord::Base
  translates :title

  def short_title
    title.gsub("Institut for ", "")
  end

  def full_title
    "#{dtu_institute_id} #{title}"
  end
end
