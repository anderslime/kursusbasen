class Api::CoursesController < ApplicationController
  respond_to :json

  def show
    respond_with Course.find(params[:id])
  end

  def index
    respond_with Course.find(params[:ids])
  end
end
