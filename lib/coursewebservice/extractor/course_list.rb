module Coursewebservice
  module Extractor
    class CourseList
      attr_reader :xml_file

      def initialize(xml_file = nil)
        @xml_file = xml_file || default_xml_course_file
      end

      def courses
        xml_file.xpath("//Course")
      end

      private

      def default_xml_course_file
        CourseXMLFileCLient.xml_file
      end
    end
  end
end
