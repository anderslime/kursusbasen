require 'openuri'

namespace :scrape_v2 do
  task :scrape_courses do
    # Get page
    url = "http://www.kurser.dtu.dk/coursewebservicev2/course.asmx/SearchDtuShb?courseCode=&searchWords=&department=&teachingPeriod=&CourseCatalogVersion=2013/2014&courseCodeStart=&teachingLanguage=&courseIDList=&resultType=fullXml&education=&CourseType=&MasterRegular=&openUniversity="

    if File.exists?("course_list.xml")
      Nokogiri::XML(IO.read("course_list.xml"))
    else
      xml_file = Nokogiri::XML(open(url))
      File.open("course_list.xml", "wb") {|f| f.write(xml_file.body) }
      xml_file
    end

    # Extract stuff
    xml_file.xpath("//Course").each do |course_xml|
      course_number = course_xml['CourseNumber']
      title =
    end
  end
end
