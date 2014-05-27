class RowContentExtractor
  attr_reader :page

  def initialize(page)
    @page = page
  end

  def content(attribute_text)
    row_index = row_index(attribute_text)
    if row_index
      extracted_content_node = page_rows[row_index + 1]
      extracted_content_node && extracted_content_node.text
    end
  end

  private

  def row_index(attribute_text)
    page_row_columns.each_with_index.map do |(first_col, _), index|
      if first_col && strip_and_chomp(first_col.text) == attribute_text
        index
      end
    end.compact.first
  end

  def strip_and_chomp(text)
    return nil unless text
    text.strip.chomp
  end

  def page_row_columns
    page_rows.map {|row| row.search("td") }
  end

  def row_at_index(index)
    return nil unless index
    page_rows[index]
  end

  def page_rows
    @page_rows ||= page.search(".CourseViewer table")[2].search("tr")
  end
end
