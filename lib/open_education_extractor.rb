class OpenEducationExtractor
  attr_reader :page

  def initialize(page)
    @page = page
  end

  def open_education?
    (page.text =~ /Kurset udbydes under/).present?
  end
end
