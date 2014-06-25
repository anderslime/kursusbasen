module Coursewebservice
  module Extractor
    class Prerequisites
      attr_reader :course_list_xml, :course, :prereq_type, :prereq_class

      def initialize(course_list_xml, course, prereq_type, prereq_class)
        @course_list_xml = course_list_xml
        @course          = course
        @prereq_type     = prereq_type
        @prereq_class    = prereq_class
      end

      def prerequisite_text
        prerequisite_text_xml.first && prerequisite_text_xml.first["Txt"]
      end

      def prerequisites
        return [] if prerequisite_courses.empty?
        prerequisite_courses.map do |prereq|
          prereq_entity = prereq_class.create!(course_id: course.id)
          prereq.split("/").map(&:strip).each do |prereq_course_number|
            prereq_entity.course_options << find_or_create_course(prereq_course_number)
          end
          prereq_entity.save!
          prereq_entity
        end
      end

      private

      def prerequisite_text_xml
        course_list_xml.xpath("//Course[@CourseCode='#{course.course_number}']//#{prereq_type}_Prerequisites_Txt[@Lang='da-DK']")
      end

      def find_or_create_course(course_number)
        if Course.exists_with_course_number?(course_number)
          Course.find_by_course_number!(course_number)
        else
          Course.create!(course_number: course_number, removed: true)
        end
      end

      def prerequisite_courses
        @prerequisite_courses_string ||= extract_prerequisites
      end

      def extract_prerequisites
        return [] if prerequisites_xml.empty?
        prerequisites_xml.first["Txt"].split(".")
      end

      def prerequisites_xml
        course_list_xml.xpath("//Course[@CourseCode='#{course.course_number}']//#{prereq_type}_Prerequisites//DTU_CoursesTxt")
      end
    end
  end
end
