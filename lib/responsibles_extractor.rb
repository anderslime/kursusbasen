class ResponsiblesExtractor
  attr_reader :page

  def initialize(page)
    @page = page
  end

  def responsibles
    responsibles = []
    teacher_elements do |name, teacher_id|
      responsibles << Responsible.new(name, teacher_id)
    end
    responsibles
  end

  private

  def teacher_ids
    @teacher_ids ||= extract_teacher_ids
  end

  def teacher_elements
    responsibles_content_node.search("a.menulink").each_with_object({}) do |link, ids|
      unless %r(mailto:.*).match(link[:href])
        teacher_id = teacher_link_regex.match(link[:href].chomp.strip)[1]
        teacher_name = link.text.chomp.strip
        yield teacher_name, teacher_id
      end
    end
  end

  def extract_teacher_name(name)
    name.strip.gsub("\n", "")
  end

  def teacher_link_regex
    %r(http:\/\/www.dtu.dk\/Service\/Telefonbog\.aspx\?id=(.*)&type=person&lg=showcommon)
  end

  def responsibles_content_node
    @responsibles_content_node ||=
      SectionContentExtractor.new(page).content_node("Kursusansvarlig:")
  end

  def responsibles_content
    SectionContentExtractor.new(page).content("Kursusansvarlig:")
  end

end
