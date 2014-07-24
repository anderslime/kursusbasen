class Api::ScheduleGroupsController < ApplicationController
  def index
    respond_with ScheduleGroup.find(params[:ids])
  end
end
