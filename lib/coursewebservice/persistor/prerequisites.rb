module Coursewebservice
  module Persistor
    class Prerequisites
      attr_reader :course, :prerequisites, :prereq_class

      def initialize(course, prerequisites, prereq_class)
        @course        = course
        @prerequisites = prerequisites
        @prereq_class  = prereq_class
      end

      def persist
        prerequisites.each do |mandatory_prerequisite|
          prerequisite = prereq_class.create(course_id: course.id)
          mandatory_prerequisite.each do |course_option_number|
            prerequisite.course_options << find_or_create_course(course_option_number)
          end
          prerequisite.save!
        end
      end

      private

      def find_or_create_course(course_number)
        if Course.exists_with_course_number?(course_number)
          Course.find_by_course_number!(course_number)
        else
          Course.create!(course_number: course_number, removed: true)
        end
      end
    end
  end
end
