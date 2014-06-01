class TopCommentExtractor
  attr_reader :page

  def initialize(page)
    @page = page
  end

  def top_comment
    top_comment_element = page.search(".CourseViewer p.normal")
    top_comment_element && top_comment_element.text.presence
  end
end
