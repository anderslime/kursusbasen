namespace :scrape do
  task :course_pages => :environment do
    collector = CourseCollector.new
    agent = Mechanize.new
    total_courses = collector.amount_of_courses
    index = 1
    collector.course_pages.each do |course_url, course_number, semester|
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

  task :course_pages_parallel => :environment do
    require "thread"

    collector      = CourseCollector.new
    objects        = collector.course_pages
    object_queue   = Queue.new
    consumer_count = 5

    def create_content_corrector(object_queue)
      corrector = Thread.new do
        while object = object_queue.pop
          break if object == 'quit'

          course_url    = object.fetch(0)
          course_number = object.fetch(1)
          semester      = object.fetch(2)
          page          = Mechanize.new.get(course_url)
          puts course_number
          unless CoursePage.exists_with_course_number_in_semester?(course_number, semester)
            CoursePage.create!(
              course_number: course_number,
              page: page.body,
              semester_year: "2013-2014",
              url: course_url
            )
          end
        end
      end
    end

    producer = Thread.new do
      objects.each {|object| object_queue << object }
      consumer_count.times { object_queue << 'quit' }
    end

    consumers = (1..consumer_count).map do |consumer|
      create_content_corrector(object_queue)
    end

    consumers.each { |consumer| consumer.join }
  end

  task :courses => :environment do
    require 'mechanize'
    require 'pp'

    debug                  = ENV["DEBUG"] || false
    persist                = ENV["PERSIST"] || false
    reset_courses_db       = ENV["RESET"] || false

    if reset_courses_db
      puts "resetting course database"
      Course.destroy_all
      Teacher.destroy_all
      Institute.destroy_all
    end

    teacher_report = File.open("teacher_report.log", "w")

    agent = Mechanize.new

    teachers = []

    [:da].each do |language|
      I18n.locale = language

      amount_of_course_pages = CoursePage.count
      existing_courses = Course.all.pluck(:course_number)

      CoursePage.except_courses(existing_courses).each_with_index do |course_page, index|
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
        # schedule_blocks = schedule_extractor.schedules
        schedule_note   = schedule_extractor.schedule_note

        # Exam schedule
        exam_schedule_extractor = ScheduleExtractor.new(page, "Eksamensplacering:")
        exam_schedules = exam_schedule_extractor.schedules
        exam_schedule_note = exam_schedule_extractor.schedule_note

        top_comment_extractor = TopCommentExtractor.new(page)
        top_comment = top_comment_extractor.top_comment

        open_education_extractor = OpenEducationExtractor.new(page)
        open_education = open_education_extractor.open_education?

        # Course language
        language_extractor = LanguageExtractor.new(page)
        language = language_extractor.language_locale_code

        # schedule_season_extractor = ScheduleSeasonBlockExtractor.new(schedule_note, schedule_blocks)
        # schedule_season_blocks = schedule_season_extractor.schedule_season_block

        # Debug output
        if debug
          [
            :course_number, :title, :ects_points, :duration, :teaching_form, :former_course,
            :participant_limit, :registration, :content, :course_ojectives, :litteratur,
            :remarks, :exam_schedule, :exam_form, :exam_duration, :exam_aid,
            :evaluation_form, :point_block, :mandatory_prerequisites,
            :optional_prerequisites, :recommended_prerequisites, :institute_dtu_id,
            :institute_title, :learning_objectives, :responsibles, :website, :schedule,
            :top_comment
          ].each do |variable|
            puts "==========#{variable}:=========="
            puts eval(variable.to_s).inspect
          end
        end

        puts "#{index + 1} / #{amount_of_course_pages}"

        # Persistence of courses
        if persist
          puts "persisting #{course_number}"

          # Create course
          course = Course.create!(
            course_number: course_number,
            ects_points: ects_points.to_f,
            homepage: website,
            exam_duration: exam_duration,
            title: title,
            teaching_form: teaching_form,
            duration: duration,
            participant_limit: participant_limit,
            registration: registration,
            course_objectives: course_ojectives,
            exam_schedule: Array(exam_schedules).join(", "),
            learn_objectives: learning_objectives,
            content: content,
            litteratur: litteratur,
            remarks: remarks,
            former_course: former_course,
            exam_form: exam_form,
            exam_aid: exam_aid,
            evaluation_form: evaluation_form,
            top_comment: top_comment,
            open_education: open_education,
            language: language,
            schedule_note: schedule_note,
            exam_schedule_note: exam_schedule_note
          )

          # Create teachers
          Array(responsibles).each do |responsible|
            teacher_data = { name: responsible.name }
            teacher = Teacher.create_with(teacher_data).find_or_create_by(
              dtu_teacher_id: responsible.dtu_teacher_id
            )
            course.teachers << teacher unless course.teachers.map(&:dtu_teacher_id).include?(teacher.dtu_teacher_id)
          end

          # Institute
          if institute_dtu_id.blank? || institute_title.blank?
            puts "no institute for #{course_number}"
          else
            institute = Institute.create_with(
              title: institute_title.gsub("\n", " ")
            ).find_or_create_by(
              dtu_institute_id: institute_dtu_id
            )
            course.institute = institute
            course.save!
          end
        end
      end
    end
  end

  task :schedules => :environment do
    if ENV["RESET"].present?
      ScheduleGroup.delete_all
      Schedule.delete_all
    end

    ListScheduleExtractor.new.courses.each do |schedule_course|
      puts schedule_course.course_number
      course = Course.find_by!(course_number: schedule_course.course_number)
      schedule_course.course_runs.each do |course_run|
        schedule_group = ScheduleGroup.create!(course_id: course.id)
        course_run.schedules.each do |schedule|
          schedule_group.schedules.create!(
            season: schedule.season,
            block: schedule.block,
            outside_dtu_schedule: schedule.outside_dtu_schedule?
          )
        end
      end
    end
  end

  task :teacher_pages => :environment do
    agent = Mechanize.new
    existing_teacher_pages = TeacherPage.all.pluck(:dtu_teacher_id)
    Teacher.excluding_teachers(existing_teacher_pages).each do |teacher|
      unless TeacherPage.exists?(dtu_teacher_id: teacher.dtu_teacher_id)
        puts "scraping page for teacher: #{teacher.dtu_teacher_id} #{teacher.id} #{teacher.name}"
        teacher_url = "http://www.dtu.dk/Service/Telefonbog.aspx?id=#{teacher.dtu_teacher_id}&type=person&lg=showcommon"
        begin
          page = agent.get(teacher_url)
          teacher_page = TeacherPage.create_with(
            url: teacher_url,
            page: page.body
          ).find_or_create_by(
            dtu_teacher_id: teacher.dtu_teacher_id
          )
        rescue Mechanize::RedirectLimitReachedError
          puts "could not scrape teacher: #{teacher.dtu_teacher_id}"
        end
      end
    end

  end

  task :teachers => :environment do
    teacher_amount = Teacher.count
    TeacherPage.all.each_with_index do |teacher_page, index|
      puts "scraping teachers #{index + 1} / #{teacher_amount}"
      page = Nokogiri::HTML(teacher_page.page)
      detail_extractor = ResponsibleDetailsExtractor.new(page)
      teacher_attributes = {
        phone: detail_extractor.phone.presence,
        email: detail_extractor.email.presence,
        website: detail_extractor.website.presence,
        office_location: detail_extractor.office_location.presence
      }
      teacher = Teacher.find_by(dtu_teacher_id: teacher_page.dtu_teacher_id)
      teacher.update_attributes(teacher_attributes)
    end
  end
end
