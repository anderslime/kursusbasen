class Course < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  validates_uniqueness_of :course_number

  translates :title, :teaching_form, :duration, :participant_limit, :registration,
             :course_objectives, :exam_schedule, :learn_objectives, :content,
             :litteratur, :remarks, :top_comment, :former_course, :exam_form,
             :exam_aid, :evaluation_form

  class << self
    def search(search_params, page)
      tire.search(load: true, page: page) do
        query do
          string(
            search_params[:query],
            default_operator: "AND"
          ) if search_params[:query].present?
        end
      end
    end
  end
end
