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

      # Evaluation data
      exam_schedule = mandatory_extractor.exam_schedule
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
      qualified_prerequisites = preqreq_extractor.qualified_prerequisites

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

      if debug
        puts course_number
        puts title
        puts duration
        puts teaching_form
        puts former_course
        puts participant_limit
        puts registration
        puts content
        puts course_ojectives
        puts litteratur
        puts remarks
        puts exam_schedule
        puts exam_form
        puts exam_duration
        puts exam_aid
        puts evaluation_form
        puts point_block
        puts mandatory_prerequisites
        puts optional_prerequisites
        puts qualified_prerequisites
        puts institute_dtu_id
        puts institute_title
        puts learning_objectives
        puts responsibles.inspect
      end
    end
  end
end
