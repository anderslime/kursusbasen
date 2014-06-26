class Course < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  serialize :learn_objectives, Array

  has_many :schedule_groups, :dependent => :destroy
  has_many :schedules, :through => :schedule_groups
  has_many :qualified_prerequisites
  has_many :mandatory_prerequisites
  has_and_belongs_to_many :teachers
  belongs_to :institute

  delegate :full_title, :short_title, to: :institute, prefix: true

  validates_uniqueness_of :course_number

  translates :title, :teaching_form, :duration, :participant_limit, :registration,
             :course_objectives, :exam_schedule, :learn_objectives, :content,
             :litteratur, :remarks, :top_comment, :former_course, :exam_form,
             :exam_aid, :evaluation_form, :schedule_note, :exam_schedule_note,
             :qualified_prerequisites_text, :mandatory_prerequisites_text

  class << self
    def search(search_params, page)
      return none.paginate(page: page) unless !search_params[:query].nil?
      tire.search(load: true, page: page) do
        query { string(search_params[:query], default_operator: "AND") }
      end
    end

    def present
      where(removed: false)
    end

    def none
      where(:id => nil).where.not(:id => nil)
    end

    def find_by_course_number!(course_number)
      find_by!(course_number: course_number)
    end

    def exists_with_course_number?(course_number)
      exists?(course_number: course_number)
    end
  end

  def any_mandatory_prerequisites?
    mandatory_prerequisites.any?
  end

  def any_qualified_prerequisites?
    qualified_prerequisites.any?
  end

  def to_param
    course_number
  end
end
