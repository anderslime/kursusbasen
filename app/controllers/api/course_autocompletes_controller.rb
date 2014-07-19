class Api::CourseAutocompletesController < ApplicationController
  respond_to :json

  def index
    courses = Course.search(search_params, 0)
    render json: courses, each_serializer: CourseAutocompleteSerializer
  end

  private

  def search_params
    params.permit(:query) || {}
  end
end
