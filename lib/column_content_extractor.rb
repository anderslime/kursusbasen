class ColumnContentExtractor
  attr_reader :page

  def initialize(page)
    @page = page
  end

  def content(attribute_text)
    strip_and_chomp(content_element(attribute_text).text)
  end

  def content_node(attribute_text)
    Array(row(attribute_text)).fetch(1) { nil }
  end

  private

  def content_element(attribute_text)
    Array(row(attribute_text)).fetch(1) { OpenStruct.new(:text => nil) }
  end

  def row(attribute_text)
    page_row_columns.find do |first_col, second_col|
      first_col && strip_and_chomp(first_col.text) == attribute_text
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
end
