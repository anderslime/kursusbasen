class Api::StudentsController < ApplicationController
  respond_to :json

  def show
    respond_with Student.find_by_student_number(params[:id])
  end
end
