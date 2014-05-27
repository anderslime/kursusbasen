class CourseCollector
  def collect_course_numbers
    table_columns_with_course_number.map(&:text)
  end

  private

  def table_columns_with_course_number
    table_columns.select {|column| column.text =~ /^\d{5}$/ }
  end

  def table_columns
    get_course_list_page.search("td")
  end

  def get_course_list_page
    agent.get(course_list_url)
  end

  def course_list_url
    "http://www.kurser.dtu.dk/2012-2013/ShowCourseList.aspx?department=1"
  end

  def agent
    @agent ||= Mechanize.new
  end
end
