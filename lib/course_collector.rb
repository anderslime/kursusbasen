class CourseCollector
  attr_reader :semester_year

  def initialize(semester_year)
    @semester_year = semester_year
  end

  def course_pages
    course_urls.map do |url|
      [url, extract_course_number(url), "2013-2014"]
    end
  end

  def amount_of_courses
    course_urls.length
  end

  private

  def extract_course_number(url)
    %r{(\w{5})\.aspx\?menulanguage=.*}.match(url)[1]
  end

  def course_urls
    get_course_list_page.links_with(:href => %r{\w{5}\.aspx\?menulanguage=.*}).map do |link|
      ["http://www.kurser.dtu.dk", link.href.to_s].join("/")
    end
  end

  def get_course_list_page
    @get_course_list_page ||= agent.get(course_list_url)
  end

  def course_list_url
    "http://www.kurser.dtu.dk/search.aspx?lstDepartment=1,10,11,12,13,23,24,25,26,27,28,30,31,33,34,41,42,46,47,48,59,IHK,83&YearGroup=#{semester_year}"
  end

  def agent
    @agent ||= Mechanize.new
  end
end
