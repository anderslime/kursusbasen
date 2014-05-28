class TextDataExtractor
  attr_reader :page

  def initialize(page)
    @page = page
  end

  def content
    extract(:content)
  end

  def course_ojectives
    extract(:course_objectives)
  end

  def litteratur
    extract(:litteratur)
  end

  def remarks
    extract(:remarks)
  end

  private

  def extract(title_key)
    SectionContentExtractor.new(page).content(attribute_titles[title_key])
  end

  def attribute_titles
    {
      :course_objectives => "Overordnede kursusmål:",
      :content => "Kursusindhold:",
      :litteratur => "Litteratur:",
      :remarks => "Bemærkninger:"
    }
  end
end
