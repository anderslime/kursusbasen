class Api::StudentsController < ApplicationController
  respond_to :json

  def show
    respond_with Student.find(params[:id])
  end
end
