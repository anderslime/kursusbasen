class CourseDataExtractor
  attr_reader :page, :course_number

  def initialize(page, course_number)
    @page          = page
    @course_number = course_number
  end

  def title
    /\d{5}.(.*)/.match(title_text)[1]
  end

  private

  # Title extraction
  def title_text
    text_in_h2s.find {|text| text =~ Regexp.new(course_number) }
  end

  def text_in_h2s
    h2s.map(&:text)
  end

  def h2s
    Array(page.search("h2"))
  end
end
