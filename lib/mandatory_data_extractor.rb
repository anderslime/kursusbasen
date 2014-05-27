class MandatoryDataExtractor
  attr_reader :page

  def initialize(page)
    @page = page
  end

  def teaching_form
    extract(:teaching_form)
  end

  def duration
    extract(:duration)
  end

  def former_course
    extract(:former_course)
  end

  def participant_limit
    extract(:participant_limit)
  end

  def registration
    extract(:registration)
  end

  def exam_schedule
    extract(:exam_schedule)
  end

  def exam_form
    extract(:exam_form)
  end

  def exam_duration
    extract(:exam_duration)
  end

  def exam_aid
    extract(:exam_aid)
  end

  def evaluation_form
    extract(:evaluation_form)
  end

  private

  def extract(title_key)
    strip_and_chomp(content_column_for_title(title_key).text)
  end

  def content_column_for_title(title_key)
    Array(row_for_title(title_key)).fetch(1) { OpenStruct.new(:text => nil) }
  end

  def row_for_title(title_key)
    page_row_columns.find do |first_col, second_col|
      first_col && strip_and_chomp(first_col.text) == row_titles[title_key]
    end
  end

  def strip_and_chomp(text)
    return nil unless text
    text.strip.chomp
  end

  def page_row_columns
    page_rows.map {|row| row.search("td") }
  end

  def page_rows
    @page_rows ||= page.search(".CourseViewer table")[2].search("tr")
  end

  def row_titles
    {
      :teaching_form => "Undervisningsform:",
      :duration => "Kursets varighed:",
      :former_course => "Tidligere kursus:",
      :participant_limit => "Deltagerbegrænsning:",
      :registration => "Tilmelding:",
      :exam_schedule => "Date of examination:",
      :exam_form => "Type of assessment:",
      :exam_duration => "Exam duration:",
      :exam_aid => "Aid:",
      :evaluation_form => "Evaluation:"
    }
  end
end
