namespace :scrape do
  task :course_pages => :environment do
    collector = CourseCollector.new
    agent = Mechanize.new
    total_courses = collector.amount_of_courses
    index = 1
    collector.course_pages do |course_url, course_number, semester|
      puts "#{index} / #{total_courses}"
      puts course_number
      page = agent.get(course_url)
      unless CoursePage.exists_with_course_number_in_semester?(course_number, semester)
        CoursePage.create!(
          course_number: course_number,
          page: page.body,
          semester_year: "2013-2014",
          url: course_url
        )
      end
      index += 1
    end
  end

  task :courses => :environment do
    require 'mechanize'
    require 'pp'

    debug = true

    agent = Mechanize.new

    [:da].each do |language|
      I18n.available_locales = [ :da, :en ]
      I18n.locale = language

      CoursePage.first(100).each do |course_page|
        page = Nokogiri::HTML(course_page.page)
        course_number = course_page.course_number

        # Get course title
        extractor = CourseDataExtractor.new(page, course_number)
        title = extractor.title

        # Mandatory data
        mandatory_extractor = MandatoryDataExtractor.new(page)
        duration = mandatory_extractor.duration
        teaching_form = mandatory_extractor.teaching_form
        former_course = mandatory_extractor.former_course
        participant_limit = mandatory_extractor.participant_limit
        registration = mandatory_extractor.registration
        ects_points = mandatory_extractor.ects_points

        # Evaluation data
        exam_form = mandatory_extractor.exam_form
        exam_duration = mandatory_extractor.exam_duration
        exam_aid = mandatory_extractor.exam_aid
        evaluation_form = mandatory_extractor.evaluation_form

        # Text attributes
        text_extractor = TextDataExtractor.new(page)
        content = text_extractor.content
        course_ojectives = text_extractor.course_ojectives
        litteratur = text_extractor.litteratur
        remarks = text_extractor.remarks

        # Prereqs
        preqreq_extractor = LegacyPrerequisitesExtractor.new(page)
        point_block = preqreq_extractor.point_block
        mandatory_prerequisites = preqreq_extractor.mandatory_prerequisites
        optional_prerequisites = preqreq_extractor.optional_prerequisites
        recommended_prerequisites = preqreq_extractor.recommended_prerequisites

        # Institut
        institute_extractor = InstituteExtractor.new(page)
        institute_dtu_id = institute_extractor.dtu_id
        institute_title = institute_extractor.title

        # Learning objectives
        learn_obj_extractor = LearningObjectivesExtractor.new(page)
        learning_objectives = learn_obj_extractor.learning_objectives

        # Responsible
        responsible_extractor = ResponsiblesExtractor.new(page)
        responsibles = responsible_extractor.responsibles

        # Website
        website_extractor = WebsiteExtractor.new(page)
        website = website_extractor.website

        # Keywords
        # keywords_extractor = KeywordsExtractor.new(page)
        # keywords = keywords_extractor.keywords

        # Schedule
        schedule_extractor = ScheduleExtractor.new(page, "Skemaplacering:")
        schedule = schedule_extractor.schedule

        # Exam schedule
        exam_schedule_extractor = ScheduleExtractor.new(page, "Eksamensplacering:")
        exam_schedule = exam_schedule_extractor.schedule

        if debug
          [
            :course_number, :title, :ects_points, :duration, :teaching_form, :former_course,
            :participant_limit, :registration, :content, :course_ojectives, :litteratur,
            :remarks, :exam_schedule, :exam_form, :exam_duration, :exam_aid,
            :evaluation_form, :point_block, :mandatory_prerequisites,
            :optional_prerequisites, :recommended_prerequisites, :institute_dtu_id,
            :institute_title, :learning_objectives, :responsibles, :website, :schedule
          ].each do |variable|
            puts "==========#{variable}:=========="
            puts eval(variable.to_s).inspect
          end
        end
      end
    end
  end
end
