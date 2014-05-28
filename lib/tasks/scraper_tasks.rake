namespace :scrape do
  task :courses => :environment do
    require 'mechanize'
    require 'pp'

    debug = true

    [:da].each do |language|
      course_numbers = CourseCollector.new.collect_course_numbers
      course_number = course_numbers[10]

      # Extract HTML Page
      course_page = "http://www.kurser.dtu.dk/2012-2013/#{course_number}.aspx"
      agent = Mechanize.new
      file_name = "#{course_number}.html"
      page = if File.exists?(file_name)
        Nokogiri::HTML(IO.read(file_name))
      else
        page_object = agent.get(course_page)
        page_object.save file_name
        page_object
      end

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
