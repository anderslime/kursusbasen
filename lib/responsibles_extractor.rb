class ResponsiblesExtractor
  attr_reader :page

  def initialize(page)
    @page = page
  end

  def responsibles
    teacher_elements.map do |teacher|
      teacher_name = extract_teacher_name(teacher[0])
      Responsible.new(
        teacher_name,
        teacher[2],
        teacher[3].gsub("\n", ""),
        teacher[4],
        teacher_ids[teacher_name]
      )
    end
  end

  private

  def teacher_ids
    @teacher_ids ||= extract_teacher_ids
  end

  def teacher_elements
    responsibles_content.
      scan(/([A-Z][^\d@,]+) , (([\d|\s|[a-zA-Z]]+, [\d|\s|[a-zA-Z]]+), )?Tlf\. (\(\+\d*\).\d*\W*\d*)?[, ]?, (.*@.*)/)
  end

  def extract_teacher_ids
    responsibles_content_node.search("a.menulink").each_with_object({}) do |link, ids|
      unless %r(mailto:.*).match(link[:href])
        teacher_id = teacher_link_regex.match(link[:href].chomp.strip)[1]
        teacher_name = link.text.chomp.strip
        ids[teacher_name] = teacher_id
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

class Responsible
  attr_reader :name, :office_location, :phone, :email, :dtu_teacher_id

  def initialize(name, office_location, phone, email, dtu_teacher_id)
    @name            = name
    @office_location = office_location
    @phone           = phone
    @email           = email
    @dtu_teacher_id  = dtu_teacher_id
  end
end
