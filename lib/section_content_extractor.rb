class SectionContentExtractor
  attr_reader :page

  def initialize(page)
    @page = page
  end

  def content(attribute_text)
    node = content_node(attribute_text)
    if node
      title_text = node.search("h3").text
      node.text[(title_text.length + line_break.length)..-1]
    end
  end

  def content_node(attribute_text)
    section_title_nodes.find do |section_node|
      section_node.search("h3").text == attribute_text
    end
  end

  private

  def line_break
    "\n"
  end

  def section_title_nodes
    page.search(".section")
  end
end
