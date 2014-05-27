class InstituteExtractor
  attr_reader :page

  def initialize(page)
    @page = page
  end

  def dtu_id
    institute_text[0, 2]
  end

  def title
    institute_text[3, institute_text.length]
  end

  private

  def institute_text
    @institute_text ||= ColumnContentExtractor.new(page).content("Institut:")
  end
end
