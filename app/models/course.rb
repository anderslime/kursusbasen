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
      return none unless !search_params[:query].nil?
      tire.search(load: true, page: page) do
        query { string(search_params[:query], default_operator: "AND") }
      end
    end

    def none
      where(:id => nil).where.not(:id => nil)
    end
  end
end
