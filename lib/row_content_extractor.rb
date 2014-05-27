class RowContentExtractor
  attr_reader :page, :skip_rows

  def initialize(page, skip_rows = 1)
    @page      = page
    @skip_rows = skip_rows
  end

  def content(attribute_text)
    extracted_content_node = content_node(attribute_text)
    extracted_content_node && extracted_content_node.text
  end

  def content_node(attribute_text)
    row_index = row_index(attribute_text)
    row_index && page_rows[row_index + skip_rows]
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
