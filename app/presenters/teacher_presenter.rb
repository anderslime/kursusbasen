class TeacherPresenter < ApplicationPresenter
  presents :teacher

  delegate :name, :email, to: :teacher

  def teacher_image_url
    return placeholder_image if teacher.dtu_teacher_id.nil?
    "https://www.dtubasen.dtu.dk/showimage.aspx?id=#{teacher.dtu_teacher_id}&x=120"
  end

  private

  def placeholder_image
    "http://placekitten.com/150/150"
  end
end
