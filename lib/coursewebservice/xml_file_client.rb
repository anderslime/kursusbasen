require 'open-uri'

module Coursewebservice
  class XMLFileClient
    COURSE_FILE_PATH = "xml_file_client_cache.xml"

    attr_reader :url

    def initialize(url)
      @url = url
    end

    def xml_file
      if course_file_cached?
        Nokogiri::XML(read_course_file_from_cache)
      else
        xml_file = Nokogiri::XML(open(url))
        File.open("course_list.xml", "wb") {|f| f.write(xml_file.to_xml) }
        xml_file
      end
    end

    private

    def course_file_cached?
      File.exists?(COURSE_FILE_PATH)
    end

    def read_course_file_from_cache
      IO.read(COURSE_FILE_PATH)
    end
  end
end
