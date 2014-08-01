require 'open-uri'

namespace :scrape_v2 do
  task :scrape_courses => :environment do
    MandatoryPrerequisite.destroy_all
    QualifiedPrerequisite.destroy_all
    Coursewebservice::Extractor::CourseList.new.courses.each do |course_xml|
      # Add Prerequisites to courses
      course_number = course_xml["CourseCode"]
      puts course_number
      course = Course.find_by_course_number(course_number)

      next if course.nil?

      # Extract prerequisites
      mand_prereq_extractor = Coursewebservice::Extractor::Prerequisites.new(course_xml, course, "Mandatory")
      qual_prereq_extractor = Coursewebservice::Extractor::Prerequisites.new(course_xml, course, "Qualified")
      mand_prereq_text = mand_prereq_extractor.prerequisite_text
      qual_prereq_text = qual_prereq_extractor.prerequisite_text

      # Persist prerequisites
      Coursewebservice::Persistor::Prerequisites.new(
        course,
        mand_prereq_extractor.prerequisites,
        MandatoryPrerequisite
      ).persist
      Coursewebservice::Persistor::Prerequisites.new(
        course,
        qual_prereq_extractor.prerequisites,
        QualifiedPrerequisite
      ).persist
      course.update_attributes(
        mandatory_prerequisites_text: mand_prereq_text,
        qualified_prerequisites_text: qual_prereq_text
      )
    end
  end
end
