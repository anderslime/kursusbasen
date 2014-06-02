class Course < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  has_many :schedules, dependent: :destroy
  has_and_belongs_to_many :teachers
  belongs_to :institute

  delegate :full_title, :short_title, to: :institute, prefix: true

  validates_uniqueness_of :course_number

  translates :title, :teaching_form, :duration, :participant_limit, :registration,
             :course_objectives, :exam_schedule, :learn_objectives, :content,
             :litteratur, :remarks, :top_comment, :former_course, :exam_form,
             :exam_aid, :evaluation_form, :schedule_note, :exam_schedule_note

  class << self
    def search(search_params, page)
      return none.paginate(page: page) unless !search_params[:query].nil?
      tire.search(load: true, page: page) do
        query { string(search_params[:query], default_operator: "AND") }
      end
    end

    def none
      where(:id => nil).where.not(:id => nil)
    end

    def find_by_course_number!(course_number)
      find_by!(course_number: course_number)
    end
  end

  def to_param
    course_number
  end
end
