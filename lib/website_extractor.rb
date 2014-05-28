class WebsiteExtractor
  attr_reader :page

  def initialize(page)
    @page = page
  end

  def website
    content_node && content_node.at_css("a")[:href]
  end

  private

  def content_node
    ColumnContentExtractor.new(page).content_node("Kursushjemmeside:")
  end
end
