class Api::CourseAutocompletesController < ApplicationController
  respond_to :json

  def index
    respond_with(
      Course.search(search_params, 0).to_a,
      each_serializer: CourseAutocompleteSerializer,
      root: false
    )
  end

  private

  def search_params
    params.permit(:query) || {}
  end
end
