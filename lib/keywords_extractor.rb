class KeywordsExtractor
  attr_reader :page

  def initialize(page)
    @page = page
  end

  def keywords
    keywords_content.split(",").map do |keyword|
      keyword.chomp.strip
    end
  end

  private

  def keywords_content
    ColumnContentExtractor.new(page).content("Nøgleord:")
  end
end
