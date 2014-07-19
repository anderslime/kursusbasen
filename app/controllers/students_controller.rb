class StudentsController < ApplicationController
  layout 'student'

  def show
    @student_number = params[:id]
  end
end
