class LearningObjectivesExtractor
  attr_reader :page

  def initialize(page)
    @page = page
  end

  def learning_objectives
    objectives_content.search("td ul li").map do |objective|
      objective.text.chomp.strip
    end.uniq
  end

  private

  def objectives_content
    @objectives_content ||= SectionContentExtractor.new(page).content_node("Læringsmål:")
  end
end
