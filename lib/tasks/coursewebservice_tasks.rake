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
      mand_prereq_extractor = Coursewebservice::Extractor::Prerequisites.new(course_xml, course, "Mandatory", MandatoryPrerequisite)
      qual_prereq_extractor = Coursewebservice::Extractor::Prerequisites.new(course_xml, course, "Qualified", QualifiedPrerequisite)

      puts "mandatory:"
      puts mand_prereq_extractor.prerequisites
      puts "qualified:"
      puts qual_prereq_extractor.prerequisites

      course.save!

      mand_prereq_text = mand_prereq_extractor.prerequisite_text
      qual_prereq_text = qual_prereq_extractor.prerequisite_text

      course.update_attributes(
        mandatory_prerequisites_text: mand_prereq_text,
        qualified_prerequisites_text: qual_prereq_text
      )
    end
  end
end
