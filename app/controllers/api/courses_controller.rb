class Api::CoursesController < ApplicationController
  respond_to :json

  def index
    respond_with Course.find(params[:ids])
  end
end
