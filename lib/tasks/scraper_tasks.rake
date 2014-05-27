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

      # Text attributes
      text_extractor = TextDataExtractor.new(page)
      content = text_extractor.content
      course_ojectives = text_extractor.course_ojectives
      litteratur = text_extractor.litteratur
      remarks = text_extractor.remarks

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
      end
    end
  end
end
