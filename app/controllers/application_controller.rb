class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  def current_student
    @current_student ||= Student.find_by_student_number('s103457')
  end

  def current_student?
    current_student.present?
  end
  helper_method :current_student, :current_student?
end
