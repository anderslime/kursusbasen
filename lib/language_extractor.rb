class LanguageExtractor
  attr_reader :page

  def initialize(page)
    @page = page
  end

  def language_locale_code
    {
      "Dansk"   => "da",
      "English" => "en"
    }.fetch(extracted_language)
  end

  private

  def extracted_language
    ColumnContentExtractor.new(page).content("Sprog:")
  end
end
