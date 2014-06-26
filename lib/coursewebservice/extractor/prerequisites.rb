module Coursewebservice
  module Extractor
    class Prerequisites
      attr_reader :course_list_xml, :course, :prereq_type

      def initialize(course_list_xml, course, prereq_type)
        @course_list_xml = course_list_xml
        @course          = course
        @prereq_type     = prereq_type
      end

      def prerequisite_text
        prerequisite_text_xml.first && prerequisite_text_xml.first["Txt"]
      end

      def prerequisites
        return [] if prerequisite_courses.empty?
        prerequisite_courses.map do |prereq|
          prereq.split("/").map(&:strip)
        end
      end

      private

      def prerequisite_text_xml
        course_list_xml.xpath("//Course[@CourseCode='#{course.course_number}']//#{prereq_type}_Prerequisites_Txt[@Lang='da-DK']")
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
