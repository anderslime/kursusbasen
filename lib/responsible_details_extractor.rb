class ResponsibleDetailsExtractor
  attr_reader :page

  def initialize(page)
    @page = page
  end

  def phone
    phone = page.search(".personMain .phonelink")
    phone && phone.text
  end

  def email
    email = Array(page.search(".personMain a")).find do |link|
      %r(mailto:.*).match(link[:href])
    end
    email && email.text.chomp.strip
  end

  def website
    website_element = page.search("#outercontent_0_content_0_TabsContent_ctl01_WebsiteLabel a").first
    website_element && website_element[:href].chomp.strip
  end

  def office_location
    location_element = Array(page.search(".personMain .address")).find do |p_tag|
      %r{Bygning\s}.match(p_tag.text)
    end
    location_element && location_element.text.chomp.strip
  end
end
